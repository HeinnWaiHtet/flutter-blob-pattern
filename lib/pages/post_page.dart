import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import "package:blob_pattern/utils/app_constants.dart";

class PostPage extends StatefulWidget {
  const PostPage({ Key? key }) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  List<Map<String, dynamic>> list_data = [];

  /**
   * get data from json placeholder
   */
  getData() async{
    await http.get(Uri.parse(POST_LINK)).then((res){
      if(res.statusCode == 200){
        List<dynamic> list = convert.jsonDecode(res.body);

        list_data = list.map((e) {
          Map<String, dynamic> map = Map();
          map["userId"] = e["userId"];
          map["id"] = e["id"];
          map["title"] = e["title"];
          map["body"] = e["body"];
          return map;
        }).toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc Post"),
      ),
      body: ListView.builder(
        itemCount: list_data.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
            child: Column(
              children: [
                Text("User ID : ${list_data[index]['userId'].toString()}"),
                Text("Id ${list_data[index]['id'].toString()}"),
                Text("Id ${list_data[index]['title'].toString()}"),
                Text("Id ${list_data[index]['body'].toString()}"),
              ]
            ),
          );
        }
      ),
    );
  }
}
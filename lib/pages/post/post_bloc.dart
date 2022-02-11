import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import "package:blob_pattern/utils/app_constants.dart";

class PostBloc{
  StreamController<List<Map<String, dynamic>>> postController = StreamController();

  Stream<List<Map<String, dynamic>>> postStream() => postController.stream;

  /**
   * get data from json placeholder
   */
  getData() async{
    List<Map<String, dynamic>> list_data = [];
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
      }else{
        print('error');
      }
    });

    postController.sink.add(list_data);
  }

  dispose(){
    postController.close();
  }
}
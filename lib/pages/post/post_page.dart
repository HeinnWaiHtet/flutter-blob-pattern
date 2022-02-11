import 'package:blob_pattern/pages/post/post_bloc.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({ Key? key }) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  // instace of bloc for post
  late PostBloc postBloc;

  /**
   * Bloc instace create and get Data
   */
  @override
  void initState() {
    super.initState();
    postBloc = PostBloc();
    postBloc.getData();
  }

  /**
   * bloc instace destroy when app exit
   */
  @override
  void dispose() {
    super.dispose();
    postBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc Post"),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        initialData: [],
        stream: postBloc.postStream(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index){
              return Card(
                child: Column(
                  children: [
                    Text("User ID : ${snapshot.data![index]['userId'].toString()}"),
                    Text("Id ${snapshot.data![index]['id'].toString()}"),
                    Text("Title ${snapshot.data![index]['title'].toString()}"),
                    Text("Body ${snapshot.data![index]['body'].toString()}"),
                  ]
                ),
              );
            }
          );
        }
      ),
    );
  }
}
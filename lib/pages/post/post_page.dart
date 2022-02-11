import 'package:blob_pattern/models/response.dart';
import 'package:blob_pattern/pages/post/post_bloc.dart';
import 'package:blob_pattern/utils/app_constants.dart';
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
      body: StreamBuilder<Response>(
        initialData: Response(
          dataState: AppDataState.loading,
          data: null
        ),
        stream: postBloc.postStream(),
        builder: (context, snapshot) {
          Response response = Response(
            dataState: snapshot.data!.dataState,
            data: snapshot.data!.data
          );

          if(response.dataState == AppDataState.loading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(response.dataState == AppDataState.data){
              return ListView.builder(
              itemCount: response.data!.length,
              itemBuilder: (BuildContext context, int index){
                return Card(
                  child: Column(
                    children: [
                      Text("User ID : ${response.data![index]['userId'].toString()}"),
                      Text("Id ${response.data![index]['id'].toString()}"),
                      Text("Title ${response.data![index]['title'].toString()}"),
                      Text("Body ${response.data![index]['body'].toString()}"),
                    ]
                  ),
                );
              }
            );
          }else if(response.dataState == AppDataState.error){
            return Center(
              child: TextButton(
                child: Text("Try Again"),
                onPressed: (){
                  postBloc.getData();
                },
              ),
            );
          }
          
          return Center(
            child: Text("Error"),
          );
        }
      ),
    );
  }
}
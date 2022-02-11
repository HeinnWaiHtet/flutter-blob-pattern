import 'dart:async';
import 'dart:convert' as convert;
import 'package:blob_pattern/models/response.dart';
import 'package:http/http.dart' as http;
import "package:blob_pattern/utils/app_constants.dart";

class PostBloc{
  StreamController<Response> postController = StreamController();

  Stream<Response> postStream() => postController.stream;

  /**
   * get data from json placeholder
   */
  getData() async{
    Response response = Response(dataState: AppDataState.loading, data: null);
    postController.sink.add(response);

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
        response.dataState = AppDataState.data;
        response.data = list_data;

        postController.sink.add(response);
      }else{
        response.dataState = AppDataState.error;
        response.data = "Data Fetch Error";
        postController.sink.add(response);
      }
    });
  }

  dispose(){
    postController.close();
  }
}
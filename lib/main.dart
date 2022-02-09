// ignore_for_file: deprecated_member_use

import 'package:blob_pattern/sum_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHome(),
    );
  }
}
class MyHome extends StatefulWidget {
  const MyHome({ Key? key }) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  TextEditingController num1Controller = TextEditingController(text: '0');
  TextEditingController num2Controller = TextEditingController(text: '0');
  late SumBloc sumBloc;

  @override
  void initState() {
    super.initState();
    sumBloc = SumBloc();
  }

  @override
  void dispose() {
    super.dispose();
    sumBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blob"),
        leading: Icon(Icons.ac_unit),
      ),
      body: StreamBuilder(
        stream: sumBloc.getStream(),
        builder: (context, AsyncSnapshot<double> snapshot) {
          return ListView(
            padding: EdgeInsets.all(20),
            children: [
              TextField(
                controller: num1Controller,
                keyboardType: TextInputType.number,
              ),

              TextField(
                controller: num2Controller,
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: 20,),
              
              OutlineButton(
                onPressed:  (){
                  double num1 = double.parse(num1Controller.text);
                  double num2 = double.parse(num2Controller.text);

                  sumBloc.doSum(num1, num2);
                  
                },
                child: Text("Sum"),
              ),

              Text(
                snapshot.data == null
                  ? "Result : "
                  : "Sum : ${snapshot.data.toString()}" 
              ),
            ],
          );
        },
      )
    );
  }
}
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
  int sum = 0;
  TextEditingController num1Controller = TextEditingController(text: '0');
  TextEditingController num2Controller = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blob"),
        leading: Icon(Icons.ac_unit),
      ),
      body: ListView(
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
              int num1 = int.parse(num1Controller.text);
              int num2 = int.parse(num2Controller.text);

              if(num1 != '' && num2 != ''){
                  setState(() {
                  sum = num1 + num2;
                });
              }
            },
            child: Text("Sum"),
          ),

          Text("Sum of ${num1Controller.text} and ${num2Controller.text} : ${sum}"),
        ],
      ),
    );
  }
}
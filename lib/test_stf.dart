import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget{
  const MyCheckBox({super.key});
  
  @override
  State<MyCheckBox> createState()=> MyCheckBoxState();
  
}

class MyCheckBoxState extends State<MyCheckBox>{
  Color containerColor= Colors.grey;
  bool checkBox = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('STF'),
      ),
      body: Column(
        children: 
        [

          Switch(value: checkBox, onChanged: (value){
            checkBox = value;
            setState(() {

            });
          }),





          Container(
            height: 50,
            width: 50,
            color: containerColor,
          ),
          SizedBox(height: 10,),
          Container(
            height: 50,
            width: 50,
            color: containerColor,
          ),
          SizedBox(height: 50,),
          ElevatedButton(onPressed: (){

            setState(() {
              containerColor = Colors.black;
            });
          }, child: Text('Change Color'))
        ],
      ),
    );
  }
  
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({super.key});

  @override
  State<MyCheckBox> createState() => MyCheckBoxState();

}

class MyCheckBoxState extends State<MyCheckBox> {
  Color containerColor = Colors.grey;
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

          Checkbox( value: checkBox, onChanged: (value) {
            checkBox = value!;
            setState(() {

            });
          },),
          CheckboxListTile( value: checkBox, onChanged: (value) {
            checkBox = value!;
            setState(() {

            });

          },
            // checkColor: Colors.green,
            activeColor: Colors.green,
            title: Text('I Agree'),
            subtitle: Text('I agree to all terms and conditions'),
          ),


          SwitchListTile(
            value: checkBox, onChanged: (value) {
            checkBox = value;
            setState(() {

            });
          },
            activeColor: Colors.green,
            inactiveThumbColor: Colors.red,
            inactiveTrackColor: Colors.amber,
            title: Text('WIFI'),
            subtitle: Text(checkBox? 'Connected': 'Disconnected'),
            // activeColor:,
          ),
          Row(
            children: [
              Text('WIFI'),
              SizedBox(width: 20,),
              Switch(
                  value: checkBox, onChanged: (value) {
                checkBox = value;
                setState(() {

                });
              }),
            ],
          ),


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
          ElevatedButton(onPressed: () {
            setState(() {
              containerColor = Colors.black;
            });
          }, child: Text('Change Color'))
        ],
      ),
    );
  }

}
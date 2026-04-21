
import 'package:flutter/material.dart';

class CountryModel{
  String name;
  String isoCode;
  CountryModel({required this.name,required this.isoCode});
}

List<CountryModel> countries= [
  CountryModel(name: 'Egypt', isoCode: 'EG'),
  CountryModel(name: 'Saudi-Arabia', isoCode: 'SA'),
  CountryModel(name: 'Kuwait', isoCode: 'KW'),
];

class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children:
            [
              DropdownButtonFormField(
                items: countries.map((oldElement)=> DropdownMenuItem(
                  value: oldElement.isoCode,
                    child: Text(oldElement.name)))
                    .toList(),

                // List.generate(10, (index)=>  DropdownMenuItem(
                //       value: index,
                //       child: Row(
                //     children: [
                //       Text('$index'),
                //     ],
                //   )),),

                // [
                //   DropdownMenuItem(
                //       value: '1',
                //       child: Row(
                //     children: [
                //       Text('1'),
                //     ],
                //   )),
                //   DropdownMenuItem(
                //       value: '2',
                //       child: Row(
                //     children: [
                //       Text('2'),
                //     ],
                //   )),
                // ],
                onChanged: (value){
                  print(value);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withValues(alpha: 0.5),
                  hintText: 'Enter Your Name',
                  // labelText: 'Name',
                  prefixIcon: Icon(Icons.title),
                  suffixIcon: Icon(Icons.remove_red_eye_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.green)
                  ),
                  focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                  ),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey)
                  ),

                ),
              ),
              SizedBox(height: 100,),



              TextFormField(
                enabled: true,
                obscureText: true,
                obscuringCharacter: '*',
                style: TextStyle(
                  color: Color(0xffCEEBDC)
                ),

                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withValues(alpha: 0.5),
                  hintText: 'Enter Your Name',
                  // labelText: 'Name',
                  prefixIcon: Icon(Icons.title),
                  suffixIcon: Icon(Icons.remove_red_eye_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.green)
                  ),
                  focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                  ),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey)
                  ),

                ),

              )
            ],
          ),
        ),
      ),
    );
  }
}
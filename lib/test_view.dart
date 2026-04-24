import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/*
UserModel
widget icon + username
out=> age
*/
class UserModel {
  String name;
  int age;

  UserModel({required this.name, required this.age});
}

List<UserModel> users = [
  UserModel(name: 'Ahmed', age: 21),
  UserModel(name: 'Mohamed', age: 22),
];

class CountryModel {
  String name;
  String isoCode;
  String phoneCode;

  CountryModel(
      {required this.name, required this.isoCode, required this.phoneCode});
}

// Egypt EG +20
// Saudi Arabia SA +966
// Kuwait KW +965
List<CountryModel> countries = [
  CountryModel(name: 'Egypt', isoCode: 'EG', phoneCode: '+20'),
  CountryModel(name: 'Saudi-Arabia', isoCode: 'SA', phoneCode: '+966'),
  CountryModel(name: 'Kuwait', isoCode: 'KW', phoneCode: '+965'),
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
            children: [
              DropdownButtonFormField(
                // icon: SvgPicture.asset('assetName'),
                  items: users
                      .map((oldElement) => DropdownMenuItem(
                            value: oldElement.age,
                            child: Row(
                              children: [
                                Icon(Icons.person),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(oldElement.name)
                              ],
                            ),
                          ))
                      .toList(),
                  onChanged: (value){
                    print(value);
                  }),
              DropdownButtonFormField(
                items: countries
                    .map((oldElement) => DropdownMenuItem(
                        value: oldElement,
                        child: Row(
                          children: [
                            Icon(Icons.person),
                            Text(
                                '${oldElement.name} - ${oldElement.isoCode} - ${oldElement.phoneCode}'),
                          ],
                        )))
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
                onChanged: (value) {
                  print(value?.phoneCode);
                  print(value?.name);
                  print(value?.isoCode);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withValues(alpha: 0.5),
                  hintText: 'Enter Your Name',
                  // labelText: 'Name',
                  // prefixIcon: Icon(Icons.title),
                  // suffixIcon: Icon(Icons.remove_red_eye_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.green)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              TextFormField(
                enabled: true,
                obscureText: true,
                obscuringCharacter: '*',
                style: TextStyle(color: Color(0xffCEEBDC)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withValues(alpha: 0.5),
                  hintText: 'Enter Your Name',
                  // labelText: 'Name',
                  prefixIcon: Icon(Icons.title),
                  suffixIcon: Icon(Icons.remove_red_eye_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.green)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

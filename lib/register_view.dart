import 'package:flutter/material.dart';

import 'components/default_btn.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF3F5F4),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // image
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: Image.asset(
                      'assets/images/flag.png',
                      height: MediaQuery.of(context).size.height * 0.37,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff000000).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 4),
                    child: Text(
                      'Pick Image',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    DefaultTextField(
                      hintText: 'Username',
                      prefixIconData: Icons.person,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DefaultTextField(
                      hintText: 'Password',
                      prefixIconData: Icons.key,
                      suffixIcon: Icon(Icons.lock),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DefaultTextField(
                      hintText: 'Confirm Password',
                      prefixIconData: Icons.key,
                      suffixIcon: Icon(Icons.lock),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DefaultBtn(
                      onTap: (){},
                      text: 'Register',
                    ),
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: Color(0xff149954),
                    //       foregroundColor: Colors.white,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(15)
                    //       ),
                    //       elevation: 10
                    //
                    //     ),
                    //     onPressed: (){
                    //       print('BTN Pressed');
                    //     },
                    //     child: Text('Register'),
                    //   ),
                    // )

                    SizedBox(
                      height: 40,
                    ),

                    TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already Have An Account?',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // hello ahmed
                    // Row(
                    //   children: [
                    //     Text(
                    //       'Hello my name is ahmed my age is 24 years old',
                    //       style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w400),
                    //     ),
                    //     Text(
                    //       'Ahmed',
                    //       style: TextStyle(
                    //           color: Colors.blue,
                    //           fontSize: 20,
                    //           fontWeight: FontWeight.w400),
                    //     ),
                    //   ],
                    // ),
                    // RichText(text: TextSpan(
                    //   children: [
                    //     TextSpan(text: 'Hello my name is',
                    //     style: TextStyle(
                    //         color: Colors.black,
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.w400),
                    //     ),
                    //
                    //     TextSpan(text: ' ahmed ',
                    //     style: TextStyle(
                    //         color: Colors.blue,
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.bold),
                    //     ),
                    //
                    //     TextSpan(text: 'my age is 24 years old',
                    //       style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w400),
                    //     ),
                    //   ]
                    // )),
                    // SizedBox(height: 100,)
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class DefaultTextField extends StatelessWidget {
  const DefaultTextField(
      {super.key,
      required this.hintText,
      this.prefixIconData,
      this.suffixIcon,
      this.obscureText = false});

  final String hintText;
  final IconData? prefixIconData;
  final Widget? suffixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 14, color: Colors.black),
      obscureText: obscureText,
      obscuringCharacter: '*',
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0xffCDCDCD), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0xffCDCDCD), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0xff149954), width: 1),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xff6E6A7C), fontSize: 14),
          prefixIcon: Icon(prefixIconData),
          suffixIcon: suffixIcon),
    );
  }
}

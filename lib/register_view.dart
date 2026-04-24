import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nti6/helper/custom_navigator.dart';

import 'components/default_btn.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final username = TextEditingController();

  final password = TextEditingController();

  final confirmPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

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
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      DefaultTextField(
                        controller: username,
                        hintText: 'Username',
                        prefixIconData: Icons.person,
                        validator: (String? value){
                          // if(value == null || value.isEmpty){
                          //   return 'This Field is Required';
                          // }
                          //
                          // return null;

                          // using regex
                          var emailRegex = RegExp(r"^[a-zA-z0-9._]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
                          if(!emailRegex.hasMatch(value??'')){
                            return 'Invalid Email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DefaultTextField(
                        controller: password,
                        hintText: 'Password',
                        prefixIconData: Icons.key,
                        suffixIcon: Icon(Icons.lock),
                        obscureText: true,
                        validator: (String? value){
                          if(value == null || value.isEmpty){
                            return 'This Field is Required';
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DefaultTextField(
                        controller: confirmPassword,
                        hintText: 'Confirm Password',
                        prefixIconData: Icons.key,
                        suffixIcon: Icon(Icons.lock),
                        obscureText: true,
                        validator: (String? value){
                          if(value == null || value.isEmpty){
                            return 'This Field is Required';
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      isLoading ?
                          CircularProgressIndicator():
                      DefaultBtn(
                        onTap: () {
                          if(formKey.currentState?.validate()== true) {
                            register(
                                username: username.text,
                                password: password.text
                            );
                          }
                        },
                        text: 'Register',
                      ),

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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  register({
    required String username,
    required String password
})async
  {
    setState(() {
      isLoading = true;
    });
    try{
      Dio dio = Dio();
      var response = await dio.post(
        'https://ntitodo-production-b847.up.railway.app/api/register',
        data: FormData.fromMap({
          'username': username,
          'password': password
        })
      );
      var result = response.data as Map<String, dynamic>;
      print(result['message']);
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.green,
              content: Text(result['message'], style: TextStyle(color: Colors.white),))
      );
      // TODO: goTo(context, LoginView());
    }
    catch(e){
      setState(() {
        isLoading = false;
      });
      String errorMsg = 'Something went wrong';
      if(e is DioException){
        var errorResponse = e.response?.data as Map<String, dynamic>;
        errorMsg = errorResponse['message'];
        print(errorResponse['message']);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
            content: Text(errorMsg, style: TextStyle(color: Colors.white),))
      );
    }
  }
}

class DefaultTextField extends StatelessWidget {
  const DefaultTextField(
      {super.key,
      required this.hintText,
      this.prefixIconData,
      this.suffixIcon,
      this.obscureText = false,
        required this.controller,
        this.validator
      });

  final String hintText;
  final IconData? prefixIconData;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      controller: controller,
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

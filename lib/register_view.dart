import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nti6/helper/custom_navigator.dart';
import 'package:flutter_nti6/login_view.dart';

import 'components/default_btn.dart';
import 'components/default_flag_image.dart';
import 'components/default_text_field.dart';

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
                  DefaultFlagImage(),
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
                          var emailRegex = RegExp(r"^[a-zA-Z0-9._]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
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

                          else if(value.length <6){
                            return 'Password must be at least 6 characters';
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
                            // call api request
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
                        onPressed: () {
                          goTo(context, LoginView());
                        },
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

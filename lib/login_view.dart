import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nti6/components/default_btn.dart';
import 'package:flutter_nti6/components/default_text_field.dart';
import 'package:flutter_nti6/helper/custom_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/default_flag_image.dart';
import 'home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Controllers
  final username = TextEditingController();
  final password = TextEditingController();

  // formKey
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          children: [
            DefaultFlagImage(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  DefaultTextField(
                    controller: username,
                    hintText: 'Username',
                    validator: (String? value){
                      if(value == null || value.isEmpty){
                        return 'Please enter username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DefaultTextField(
                    controller: password,
                    hintText: 'Password',
                    validator: (String? value){
                      if(value == null || value.isEmpty){
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  isLoading ?
                      CircularProgressIndicator():
                  DefaultBtn(text: 'Login', onTap: () {
                    if(formKey.currentState?.validate()== true) {
                      login();
                    }
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  login()async
  {
    setState(() {
      isLoading = true;
    });
    try{
      Dio dio = Dio();
      var response = await dio.post(
          'https://ntitodo-production-b847.up.railway.app/api/login',
          data: FormData.fromMap({
            'username': username.text,
            'password': password.text
          })
      );
      print(response.data.toString());
      var result = response.data as Map<String, dynamic>;
      String accessToken = result['access_token'];
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', accessToken);

      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.green,
              content: Text('Login Success', style: TextStyle(color: Colors.white),))
      );
      // TODO: goTo(context, HomeView());
      goTo(context, HomeView(), NavigatorType.pushAndRemoveUntil);
    }
    catch(e){
      print(e.toString());
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

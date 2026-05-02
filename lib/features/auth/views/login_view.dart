import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nti6/core/cache/cache_helper.dart';
import 'package:flutter_nti6/core/cache/cache_keys.dart';
import 'package:flutter_nti6/core/network/api_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/components/default_btn.dart';
import '../../../core/components/default_flag_image.dart';
import '../../../core/components/default_text_field.dart';
import '../../../core/helper/custom_navigator.dart';
import '../../home/views/home_view.dart';

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
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
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
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  isLoading
                      ? CircularProgressIndicator()
                      : DefaultBtn(
                          text: 'Login',
                          onTap: () {
                            if (formKey.currentState?.validate() == true) {
                              // login();
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

  // login() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   // right
  //   var response = await ApiHelper.post(
  //     endPoint: 'login',
  //     data: {'username': username.text, 'password': password.text},
  //   );
  //   response.fold(
  //     (error) {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           backgroundColor: Colors.red,
  //           content: Text(
  //             error,
  //             style: TextStyle(color: Colors.white),
  //           )));
  //     },
  //     (map)async {
  //       await CacheHelper.setValue(
  //         key: CacheKeys.accessToken,
  //         value: map[CacheKeys.accessToken]
  //       );
  //       await CacheHelper.setValue(
  //         key: CacheKeys.refreshToken,
  //         value: map[CacheKeys.refreshToken]
  //       );
  //
  //       setState(() {
  //         isLoading = false;
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           backgroundColor: Colors.green,
  //           content: Text(
  //             'Login Success',
  //             style: TextStyle(color: Colors.white),
  //           )));
  //       // TODO: goTo(context, HomeView());
  //       goTo(context, HomeView(), NavigatorType.pushAndRemoveUntil);
  //     }
  //   );
  //
  // }
}

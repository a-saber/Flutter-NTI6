import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nti6/core/cache/cache_helper.dart';
import 'package:flutter_nti6/core/cache/cache_keys.dart';
import 'package:flutter_nti6/core/network/api_helper.dart';
import 'package:flutter_nti6/features/auth/cubit/login/login_cubit.dart';
import 'package:flutter_nti6/features/auth/cubit/login/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/components/default_btn.dart';
import '../../../core/components/default_flag_image.dart';
import '../../../core/components/default_text_field.dart';
import '../../../core/helper/custom_navigator.dart';
import '../../home/views/home_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: Builder(builder: (context) {
          return Form(
            key: LoginCubit.get(context).formKey,
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
                        controller: LoginCubit.get(context).username,
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
                        controller: LoginCubit.get(context).password,
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
                      BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  state.error,
                                  style: TextStyle(color: Colors.white),
                                )));
                          }
                          else if(state is LoginSuccessState){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  'Login Success\nWelcome ${state.userModel.username}',
                                  style: TextStyle(color: Colors.white),
                                )));
                            // TODO: goTo(context, HomeView());
                            goTo(context, HomeView(),
                                NavigatorType.pushAndRemoveUntil);
                          }
                        },
                        builder: (context, state) {
                          if (state is LoginLoadingState) {
                            return CircularProgressIndicator();
                          }
                          return DefaultBtn(
                              text: 'Login',
                              onTap: LoginCubit.get(context).onLoginPressed);
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

}

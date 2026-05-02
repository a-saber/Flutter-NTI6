import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nti6/features/auth/cubit/login/login_state.dart';
import 'package:flutter_nti6/features/auth/data/repo/auth_repo.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit() : super(LoginInitialState());
  final AuthRepo repo = AuthRepo();
  static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);

  final username = TextEditingController();
  final password = TextEditingController();
  var formKey = GlobalKey<FormState>();

  onLoginPressed( ) async{
    emit(LoginLoadingState());
    var result = await repo.login(
      username: username.text,
      password: password.text
    );
    result.fold(
        (error){
          emit(LoginErrorState(error));
        },
        (userModel){
          emit(LoginSuccessState(userModel));
        }
    );
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nti6/features/auth/cubit/login/login_state.dart';
import 'package:flutter_nti6/features/auth/data/repo/auth_repo.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit() : super(LoginInitialState());
  final AuthRepo repo = AuthRepo();
  onLoginPressed(
  {
    required String username,
    required String password
}
      ) async{
    emit(LoginLoadingState());
    var result = await repo.login(
      username: username,
      password: password
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
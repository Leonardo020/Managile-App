import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mylife/models/auth/auth_token.dart';
import 'package:mylife/service/auth/login/login_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    final LoginService loginService = LoginService();

    on<AttemptLoginEvent>((event, emit) async {
      try {
        emit(LoginProcessLoading());
        AuthTokenModel authTokenModel =
            await loginService.attemptLogin(event.email, event.password);
        if (authTokenModel.error != null) {
          emit(LoginError(authTokenModel.error));
        }
        emit(LoginLoaded(authTokenModel));
      } catch (msg) {
        emit(LoginError('Erro ao realizar login: $msg'));
      }
    });
  }
}

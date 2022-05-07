import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mylife/service/auth/login/login_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    final LoginService loginService = LoginService();

    on<AttemptLoginEvent>((event, emit) async {
      try {
        emit(LoginProcessLoading());
        String token =
            await loginService.attemptLogin(event.email, event.password);
        emit(LoginLoaded(token));
      } catch (msg) {
        emit(LoginError('Erro ao realizar login: $msg'));
      }
    });
  }
}

import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mylife/models/auth/user.dart';
import 'package:mylife/service/auth/user/user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    final UserService userService = UserService();

    on<AuthUserEvent>((event, emit) async {
      try {
        emit(UserLoading());
        UserModel user = await userService.getAuthUser();
        emit(UserSingleLoaded(user));
      } catch (msg) {
        emit(UserError('Erro ao tentar trazer o usuário: $msg'));
      }
    });
  }
}

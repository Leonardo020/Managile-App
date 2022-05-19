part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class AuthUserEvent extends UserEvent {}

class RegisterUserEvent extends UserEvent {
  final UserModel? userModel;
  const RegisterUserEvent(this.userModel);

  @override
  List<Object> get props => [userModel!];
}

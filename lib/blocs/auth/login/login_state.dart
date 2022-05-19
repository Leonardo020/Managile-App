part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginProcessLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final AuthTokenModel authTokenModel;

  const LoginLoaded(this.authTokenModel);

  @override
  List<Object> get props => [authTokenModel];
}

class LoginError extends LoginState {
  final String? message;
  const LoginError(this.message);
}

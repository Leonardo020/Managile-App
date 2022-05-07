part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginProcessLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoaded extends LoginState {
  final String token;

  LoginLoaded(this.token);

  @override
  List<Object> get props => [token];
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);

  @override
  List<Object> get props => [message];
}

part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class AttemptLoginEvent extends LoginEvent {
  final String email;
  final String password;
  const AttemptLoginEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

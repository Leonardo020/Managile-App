part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserProcessLoading extends UserState {}

class UserSingleLoaded extends UserState {
  final UserModel user;

  const UserSingleLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class UserError extends UserState {
  final String? message;
  const UserError(this.message);
}

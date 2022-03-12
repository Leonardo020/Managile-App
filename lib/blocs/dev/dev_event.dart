part of 'dev_bloc.dart';

abstract class DevEvent extends Equatable {
  const DevEvent();

  @override
  List<Object> get props => [];
}

class GetDevList extends DevEvent {}

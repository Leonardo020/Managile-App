part of 'dev_bloc.dart';

abstract class DevState extends Equatable {
  const DevState();

  @override
  List<Object?> get props => [];
}

class DevInitial extends DevState {}

class DevLoading extends DevState {}

class DevLoaded extends DevState {
  final List<DevModel> devModel;
  const DevLoaded(this.devModel);
}

class DevError extends DevState {
  final String? message;
  const DevError(this.message);
}

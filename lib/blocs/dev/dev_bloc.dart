import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mylife/models/dev.dart';

import '../../resources/dev/dev_service.dart';

part 'dev_event.dart';
part 'dev_state.dart';

class DevBloc extends Bloc<DevEvent, DevState> {
  DevBloc() : super(DevInitial()) {
    final DevService _devService = DevService();

    on<GetDevList>((event, emit) async {
      try {
        emit(DevLoading());
        final mList = await _devService.fetchDevList();
        emit(DevLoaded(mList));
        if (mList.first.error != null) {
          emit(DevError(mList.first.error));
        }
      } on NetworkError {
        emit(const DevError("Failed to fetch data. Is your device online?"));
      }
    });
  }
}

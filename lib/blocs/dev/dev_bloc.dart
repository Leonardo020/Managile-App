import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mylife/models/dev.dart';

import '../../resources/api_repository.dart';

part 'dev_event.dart';
part 'dev_state.dart';

class DevBloc extends Bloc<DevEvent, DevState> {
  DevBloc() : super(DevInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetDevList>((event, emit) async {
      try {
        emit(DevLoading());
        final mList = await _apiRepository.fetchDevList();
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

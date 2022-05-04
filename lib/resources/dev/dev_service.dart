import '../../models/dev.dart';
import 'dev_repository.dart';

class DevService {
  final _repository = DevRepository();

  Future<List<DevModel>> fetchDevList() {
    return _repository.fetchDevList();
  }
}

class NetworkError extends Error {}

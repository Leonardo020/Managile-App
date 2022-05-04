import 'package:dio/dio.dart';
import 'package:mylife/models/dev.dart';
import 'package:mylife/resources/base_repository.dart';

class DevRepository extends BaseRepository {
  Future<List<DevModel>> fetchDevList() async {
    try {
      Response response = await dio.get(url[env]! + '/dev');
      var arrayDevs = response.data['data'] as List;
      return (arrayDevs).map((dev) {
        return DevModel.fromJson(dev);
      }).toList();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }
}

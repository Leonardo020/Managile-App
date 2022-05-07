import 'package:dio/dio.dart';
import 'package:mylife/models/dev.dart';
import 'package:mylife/service/base_repository.dart';

class DevRepository extends BaseRepository {
  Future<List<DevModel>> fetchDevList() async {
    try {
      Response response = await dio.get(url[env]! + '/dev');

      if (response.statusCode != 200) {
        List<DevModel> arrayDevs = [];
        arrayDevs.add(DevModel.withError("${response.data['msg']}"));
        return arrayDevs;
      }

      return (response.data['data'] as List).map((dev) {
        return DevModel.fromJson(dev);
      }).toList();
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }
}

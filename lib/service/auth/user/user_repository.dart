import 'package:dio/dio.dart';
import 'package:mylife/models/auth/user.dart';
import 'package:mylife/service/base_repository.dart';

class UserRepository extends BaseRepository {
  Future<UserModel> getAuthUser() async {
    try {
      await checkToken();
      Response response = await dio.get(url[env]! + '/user');
      if (response.statusCode != 200) {
        return UserModel.withError(response.data['msg']);
      }
      return UserModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }
}

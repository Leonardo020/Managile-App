import 'package:dio/dio.dart';
import 'package:mylife/models/auth/user.dart';
import 'package:mylife/service/base_repository.dart';

class UserRepository extends BaseRepository {
  Future<UserModel> getAuthUser() async {
    try {
      await checkToken();
      Response response = await dio.get(url[env]! + '/user');
      return response.statusCode != 200
          ? UserModel.withError(response.data['msg'])
          : UserModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }

  Future<UserModel> registerUser(UserModel model) async {
    try {
      Response response =
          await dio.post(url[env]! + '/auth/user', data: model.toJson());

      return response.statusCode != 201
          ? UserModel.withError(response.data['message'])
          : UserModel.fromJson(response.data['data']);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }
}

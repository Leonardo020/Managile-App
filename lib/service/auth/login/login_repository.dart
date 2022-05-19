import 'package:dio/dio.dart';
import 'package:mylife/models/auth/auth_token.dart';
import 'package:mylife/service/base_repository.dart';

class LoginRepository extends BaseRepository {
  Future<AuthTokenModel> attemptLogin(String email, String password) async {
    try {
      Response response = await dio.post(url[env]! + '/auth/login',
          data: {"email": email, "password": password},
          options: Options(
              headers: {"type": "app"},
              validateStatus: (status) {
                return status! < 500;
              }));
      if (response.statusCode != 200) {
        return AuthTokenModel.withError(response.data['message']);
      }

      return AuthTokenModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }
}

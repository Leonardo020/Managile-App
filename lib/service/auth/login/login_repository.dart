import 'package:dio/dio.dart';
import 'package:mylife/service/base_repository.dart';

class LoginRepository extends BaseRepository {
  Future<String> attemptLogin(String email, String password) async {
    try {
      Response response = await dio.post(url[env]! + '/auth/login',
          data: {"email": email, "password": password});

      return response.data['token'];
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      throw Exception(error);
    }
  }
}

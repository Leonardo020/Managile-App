import 'package:dio/dio.dart';
import 'package:mylife/service/utils/secure_storage.dart';

class BaseRepository {
  Env env = Env.LOCAL;
  Dio dio = Dio(BaseOptions(headers: {"Accept": "application/json"}));
  final Map<Env, String> url = {
    Env.PROD: "https://fefa-modaintima.herokuapp.com/api",
    Env.LOCAL: "http://192.168.1.106:8000/api"
  };

  checkToken() async {
    String token = await SecureStorage().jwtOrEmpty;
    if (token.isNotEmpty) {
      dio = Dio(BaseOptions(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        validateStatus: (status) {
          return status! < 500;
        },
      ));
    }
  }
}

enum Env { PROD, LOCAL }

import 'package:dio/dio.dart';

class BaseRepository {
  Env env = Env.LOCAL;
  final Dio dio = Dio();
  final Map<Env, String> url = {
    Env.PROD: "https://fefa-modaintima.herokuapp.com/api",
    Env.LOCAL: "http://192.168.1.106:8000/api"
  };
}

enum Env { PROD, LOCAL }

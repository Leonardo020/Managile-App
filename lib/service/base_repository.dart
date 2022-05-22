// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mylife/main.dart';
import 'package:mylife/routes/app_routes.dart';
import 'package:mylife/service/utils/secure_storage.dart';

class BaseRepository {
  Env env = Env.LOCAL;
  Dio dio = Dio(BaseOptions(
    headers: {"Accept": "application/json"},
    validateStatus: (status) {
      return status! < 500;
    },
  ));

  final Map<Env, String> url = {
    Env.PROD: "https://fefa-modaintima.herokuapp.com/api",
    Env.LOCAL: "http://192.168.1.106:8000/api"
  };

  Future<bool> checkToken() async {
    String? token = await SecureStorage().jwtOrEmpty;
    DateTime? dateExpires =
        DateTime.parse(await SecureStorage().expiresDate).toLocal();

    if (token.isNotEmpty && DateTime.now().isBefore(dateExpires)) {
      dio.options.headers.addAll({"Authorization": "Bearer $token"});
    } else {
      navigatorKey.currentState?.pushNamed(AppRoutes.LOGIN);
    }

    return token.isNotEmpty;
  }
}

enum Env { PROD, LOCAL }

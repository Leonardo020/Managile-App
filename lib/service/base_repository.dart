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
    Env.LOCAL: "http://192.168.1.107:8000/api"
  };

  Future<bool> checkToken() async {
    String? token = await SecureStorage().jwtOrEmpty;
    DateTime? dateExpires =
        DateTime.tryParse(await SecureStorage().expiresDate);

    bool isCheckAuth = token.isNotEmpty &&
        dateExpires != null &&
        DateTime.now().isBefore(dateExpires);

    if (isCheckAuth) {
      dio.options.headers.addAll({"Authorization": "Bearer $token"});
    }

    return isCheckAuth;
  }

  Future<void> redirectPageByAuth() async {
    bool isAuth = await checkToken();

    Timer(const Duration(seconds: 2), () {
      isAuth
          ? navigatorKey.currentState?.pushReplacementNamed(AppRoutes.HOME)
          : navigatorKey.currentState?.pushReplacementNamed(AppRoutes.LOGIN);
    });
  }
}

enum Env { PROD, LOCAL }

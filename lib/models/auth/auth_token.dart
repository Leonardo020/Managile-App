import 'package:mylife/models/base/base.dart';

class AuthTokenModel extends BaseModel {
  String? token;
  DateTime? expiresIn;

  AuthTokenModel({this.token, this.expiresIn});

  AuthTokenModel.withError(String errorMessage) {
    print(errorMessage);
    error = errorMessage;
  }

  AuthTokenModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expiresIn = DateTime.parse(json['expires_in']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role_token'] = token;
    data['expires_in'] = expiresIn;
    return data;
  }
}

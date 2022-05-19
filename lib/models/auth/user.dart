import 'package:mylife/models/auth/role.dart';
import 'package:mylife/models/base/base.dart';

class UserModel extends BaseModel {
  int? id;
  String? name;
  String? email;
  String? password;
  String? passwordConfirmation;
  RoleModel? role;

  UserModel(
      {this.id,
      this.name,
      this.password,
      this.email,
      this.passwordConfirmation});

  UserModel.withError(String errorMessage) {
    error = errorMessage;
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['user_name'];
    email = json['email'];
    role = RoleModel.fromJson(json['role']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['password_confirmation'] = passwordConfirmation;
    data['type'] = "app";

    return data;
  }
}

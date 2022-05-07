import 'package:mylife/models/auth/role.dart';

class UserModel {
  int? id;
  String? name;
  String? email;
  String? gender;
  DateTime? birthDate;
  String? error;
  RoleModel? role;

  UserModel(
      {this.id,
      this.name,
      this.gender,
      this.email,
      this.birthDate,
      this.error});

  UserModel.withError(String errorMessage) {
    error = errorMessage;
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['user_name'];
    email = json['email'];
    gender = json['gender'];
    birthDate = json['birth_date'];
    role = RoleModel.fromJson(json['role']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['gender'] = gender;
    data['birth_date'] = birthDate;

    return data;
  }
}

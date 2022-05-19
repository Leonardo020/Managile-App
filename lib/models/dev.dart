import 'package:mylife/models/base/base.dart';

class DevModel extends BaseModel {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  DevModel({this.id, this.name, this.createdAt, this.updatedAt});

  DevModel.withError(String errorMessage) {
    error = errorMessage;
  }

  DevModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = DateTime.parse(json['created_at']).toLocal();
    updatedAt = DateTime.parse(json['updated_at']).toLocal();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    return data;
  }
}

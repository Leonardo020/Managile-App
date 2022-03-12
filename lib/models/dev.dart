class DevModel {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? error;

  DevModel({this.id, this.name, this.createdAt, this.updatedAt});

  DevModel.withError(String errorMessage) {
    error = errorMessage;
  }

  DevModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
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

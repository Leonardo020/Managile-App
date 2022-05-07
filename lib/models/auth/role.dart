class RoleModel {
  int? id;
  String? name;
  String? description;

  RoleModel({this.id, this.name, this.description});

  RoleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['role_name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role_name'] = name;
    data['description'] = description;

    return data;
  }
}

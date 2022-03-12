class ProductModel {
  int? id;
  String? title;
  double? price;
  int? quantity;
  String? urlImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? error;

  ProductModel(
      {this.id,
      this.title,
      this.price,
      this.quantity,
      this.urlImage,
      this.createdAt,
      this.updatedAt});

  ProductModel.withError(String errorMessage) {
    error = errorMessage;
  }

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = double.parse(json['price']);
    quantity = json['quantity'];
    urlImage = json['urlImage'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['title'] = title;
    data['price'] = price;
    data['quantity'] = quantity;

    return data;
  }
}

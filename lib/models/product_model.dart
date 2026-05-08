class ProductModel {
  final String id;
  final String name;
  final double price;
  final String description;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"] as String,
      name: json["name"] as String,
      price: (json["price"] as num).toDouble(),
      description: json["description"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "description": description,
    };
  }
}

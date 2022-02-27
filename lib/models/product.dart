import 'dart:convert';

class Product {
  Product({
    required this.available,
    required this.name,
    required this.price,
    this.photoUrl,
    this.id,
  });

  String? id;
  bool available;
  String name;
  String? photoUrl;
  double price;

  Product copy() => Product(
        available: available,
        name: name,
        price: price,
        photoUrl: photoUrl,
        id: id,
      );

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        available: json["available"],
        name: json["name"],
        photoUrl: json["photoUrl"],
        price: json["price"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "available": available,
        "name": name,
        "photoUrl": photoUrl,
        "price": price,
      };
}

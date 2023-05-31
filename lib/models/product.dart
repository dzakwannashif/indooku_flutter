import 'category.dart';

class Product {
  final int id;
  final String name;
  final String price;
  final String stock;
  final String image;
  final String description;
  final int categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Category? category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.image,
    required this.description,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        stock: json["stock"],
        image: json["image"],
        description: json["description"],
        categoryId: json["category_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        category: json['category'] != null
            ? Category.fromJson(json["category"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "stock": stock,
        "image": image,
        "description": description,
        "category_id": categoryId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "category": category != null ? category!.toJson() : null,
      };
}

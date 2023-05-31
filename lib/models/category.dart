class Category {
  final int id;
  final String name;
  final String image;
  final int? productCount;

  Category(
      {required this.id,
      required this.name,
      required this.image,
      required this.productCount});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      productCount: json['product_count']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        'product_count': productCount,
      };
}

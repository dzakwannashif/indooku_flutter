class User {
  final int id;
  final String name;
  final String email;
  final String? image;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        'image': image,
      };
}

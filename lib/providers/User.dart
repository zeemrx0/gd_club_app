class User {
  User({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  String id;
  String name;
  String? imageUrl;
}

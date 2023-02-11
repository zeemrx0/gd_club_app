class Account {
  String id;
  String email;
  String name;
  String? imageUrl;

  Account({
    required this.id,
    required this.email,
    required this.name,
    this.imageUrl,
  });
}

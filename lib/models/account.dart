class Account {
  String id;
  String email;
  String name;
  String? avatarUrl;
  String systemRole;

  Account({
    required this.id,
    required this.email,
    required this.name,
    this.avatarUrl,
    required this.systemRole,
  });
}

class Organizer {
  final String _id;
  final String _name;
  final String? _avatarUrl;

  Organizer(this._id, this._name, this._avatarUrl);

  String get id {
    return _id;
  }

  String get name {
    return _name;
  }

  String? get avatarUrl {
    return _avatarUrl;
  }
}

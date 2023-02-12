class Role {
  final String _title;
  final bool _isManager;

  Role(this._title, this._isManager);

  String get title {
    return _title;
  }

  bool get isManager {
    return _isManager;
  }
}

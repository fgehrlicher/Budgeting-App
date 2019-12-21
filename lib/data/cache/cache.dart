class Cache {
  Map<String, dynamic> _cache = Map();

  static final Cache _instance = Cache._();

  Cache._();

  factory Cache() {
    return _instance;
  }

  void insert(String key, dynamic value) {
    _cache[key] = value;
  }

  dynamic retrieve(String key) {
    return _cache[key];
  }
}

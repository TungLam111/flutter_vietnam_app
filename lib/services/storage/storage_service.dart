
abstract class Store {
  Future<String> getValue(String key);

  Future<void> setValue(String key, dynamic value);

  Future<void> remove(String key);

  Future<void> clear();
}

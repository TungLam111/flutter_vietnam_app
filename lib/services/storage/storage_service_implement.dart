
abstract class Store<T> {
  Future<String> get(String key);

  Future<void> set(String key, T value);

  Future<void> remove(String key);

  Future<void> clear();
}

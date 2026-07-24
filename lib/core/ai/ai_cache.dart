// lib/core/ai/ai_cache.dart

class AiCache {
  static final AiCache _instance = AiCache._internal();
  factory AiCache() => _instance;
  AiCache._internal();

  final Map<String, String> _memoryCache = {};

  String? get(String key) => _memoryCache[key];

  void set(String key, String response) {
    _memoryCache[key] = response;
  }

  bool contains(String key) => _memoryCache.containsKey(key);

  void clear() => _memoryCache.clear();
}
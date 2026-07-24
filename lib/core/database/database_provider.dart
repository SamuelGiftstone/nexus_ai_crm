// lib/core/database/database_provider.dart

import 'app_database.dart';

class DatabaseProvider {
  static AppDatabase? _instance;

  static AppDatabase get instance {
    _instance ??= AppDatabase();
    return _instance!;
  }

  static Future<void> close() async {
    await _instance?.close();
    _instance = null;
  }
}
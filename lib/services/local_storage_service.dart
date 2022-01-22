import 'dart:convert';

import 'package:feelin/models/diary_entry_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static late LocalStorageService _instance;
  static late SharedPreferences _preferences;

  static late DateFormat _dateFormat = DateFormat("yyyyMMdd");

  // Singleton approach
  static Future<LocalStorageService> getInstance() async {
    _instance = LocalStorageService();
    _preferences = await SharedPreferences.getInstance();
    return _instance;
  }

  dynamic _getFromDisk(String key) {
    return _preferences.get(key);
  }

  // Value will be encoded as a JSON string
  // Anonymous type T used for dynamic reasons
  void _saveToDisk<T>(String key, T value) {
    _preferences.setString(key, json.encode(value));
  }

  DiaryEntry? getSpecificDiaryEntry(String key) {
    var diaryEntry = _getFromDisk(key) ?? null;
    if (diaryEntry != null) {
      return DiaryEntry.fromJson(json.decode(diaryEntry));
    }
    return null;
  }

  Set<String> getAllKeys() => _preferences.getKeys();

  void saveDiaryEntry(DateTime date, DiaryEntry diaryEntry) => _saveToDisk<DiaryEntry>(_dateFormat.format(date), diaryEntry);

  void removeDiaryEntry(String key) async {
    await _preferences.remove(key);
  }
}

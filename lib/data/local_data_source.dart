import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';

class LocalDataSource {
  static const String key = 'notes';
  static const String isDarkKey = 'is_dark';

  Future<List<Note>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);
    if (data == null) {
      return [];
    }
    final list = jsonDecode(data) as List;
    return list.map((e) => Note.fromJson(e)).toList();
  }

  Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(notes.map((e) => e.toJson()).toList());
    await prefs.setString(key, data);
  }

  Future<bool> getIsDark() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isDarkKey) ?? false;
  }

  Future<void> saveIsDark(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isDarkKey, value);
  }
}

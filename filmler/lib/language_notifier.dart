import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageNotifier with ChangeNotifier {
  bool _isEnglish = false;

  LanguageNotifier() {
    _loadFromPrefs();
  }

  bool get isEnglish => _isEnglish;

  toggleLanguage() {
    _isEnglish = !_isEnglish;
    _saveToPrefs();
    notifyListeners();
  }

  _loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isEnglish = prefs.getBool('isEnglish') ?? false;
    notifyListeners();
  }

  _saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isEnglish', _isEnglish);
  }
}

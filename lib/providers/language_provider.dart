import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale locale = const Locale('en');

  void changeLanguage(Locale locale) {
    this.locale = locale;
    notifyListeners();
  }
}

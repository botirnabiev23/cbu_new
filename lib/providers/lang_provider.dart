import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cbu/l10n/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;
  static const String _localeKey = 'selectedLocale';

  LocaleProvider() {
    _loadSavedLocale();
  }

  Locale? get locale => _locale;

  Future<void> setLocale(Locale locale) async {
    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
    await _saveLocaleToPreferences(locale);
  }

  Future<void> clearLocale() async {
    _locale = null;
    notifyListeners();
    await _removeLocaleFromPreferences();
  }

  Future<void> _saveLocaleToPreferences(Locale locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
  }

  Future<void> _removeLocaleFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_localeKey);
  }

  Future<void> _loadSavedLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString(_localeKey);

    if (languageCode != null) {
      _locale = L10n.all.firstWhere(
        (locale) => locale.languageCode == languageCode,
        orElse: () => L10n.all.first,
      );
      notifyListeners();
    }
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// NOTE:
// To make it work on iOS the language needs to be added to info.plist
// See for more info https://github.com/flutter/flutter/issues/14128#issuecomment-534725241

// Supported locales
const List<String> _supportedLocals = ['en', 'de'];

class AppLocal {
  AppLocal(this.locale);

  final Locale locale;

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocal of(BuildContext context) {
    return Localizations.of<AppLocal>(context, AppLocal)!;
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocal> delegate =
  _AppLocalizationsDelegate();

  late Map<String, String> _localizedStrings;

  Future<bool> load() async {
    // Load the language JSON file from the "assets/lang/" folder
    String jsonString =
    await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String key(String key) {
    return _localizedStrings[key] ?? '';
  }
}

// LocalizationsDelegate is a factory for a set of localized resources
// In this case, the localized strings will be gotten in an AppLocalizations object
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocal> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // All supported languages
    return _supportedLocals.contains(locale.languageCode);
  }

  @override
  Future<AppLocal> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppLocal localizations = new AppLocal(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

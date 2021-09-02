import 'package:flutter/material.dart';
import 'package:flutter_localization_json/app_localizations.dart';
import 'package:flutter_localization_json/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('de', 'DE'),
      ],
      localizationsDelegates: [
        AppLocal.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) {
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }

        return supportedLocales.first;
      },
      title: 'Localization',
      initialRoute: '/',
      routes: {
        '/': (context) => new HomeScreen(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_localization_json/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocal appLocal = AppLocal.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocal.key('title.app')),
      ),
      body: Center(
        child: Text(appLocal.key('body.hello')),
      ),
    );
  }
}

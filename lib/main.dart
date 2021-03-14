import 'package:easybooking/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyBooking',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        // Locale('pt', 'BR'),
        Locale('en', ''),
      ],
      theme: ThemeData(primarySwatch: Colors.amber),
      home: HomePage(),
    );
  }
}

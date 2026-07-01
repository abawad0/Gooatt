import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const QawwatApp());
}

class QawwatApp extends StatelessWidget {
  const QawwatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'قوّت',
      debugShowCheckedModeBanner: false,
      theme: QawwatTheme.theme,
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: const [
        // TODO: add flutter_localizations + GlobalMaterialLocalizations.delegate, etc.
        // for full RTL widget support (date pickers, etc.)
      ],
      home: const HomeScreen(),
    );
  }
}

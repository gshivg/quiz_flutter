// This is the main file of the app

// Flutter Dependencies
import 'package:flutter/material.dart';
// Imported Dependencies
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
// Project Dependencies
import 'package:quiz_flutter/styles/theme.dart';
import 'package:quiz_flutter/Models/theme.dart';
import 'package:quiz_flutter/firebase_options.dart';
import 'package:quiz_flutter/pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer(builder: (context, ThemeModel themeModel, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Quiz App',
          theme: themeModel.isDark ? darkTheme() : lightTheme(),
          home: const MyHomePage(),
        );
      }),
    );
  }
}

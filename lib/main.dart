import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:girdhari/firebase_options.dart';

import 'package:girdhari/screens/splash_screen.dart';

import 'package:girdhari/theme/dark_theme.dart';
import 'package:girdhari/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Girdhari-pos',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: const SplashScreen());
  }
}

import 'package:codestore/Animations/light_to_dark.dart';
import 'package:codestore/Screens/login_screen/login_screen.dart';
import 'package:codestore/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return AnimatedTheme(
          data: themeProvider.currentTheme,
          duration: const Duration(milliseconds: 500),
          child: MaterialApp(
            title: 'App Demo',
            theme: themeProvider.currentTheme,
            home: const LoginSignupScreen(),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}

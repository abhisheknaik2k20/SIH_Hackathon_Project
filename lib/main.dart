import 'package:codestore/Animations/light_to_dark.dart';
import 'package:codestore/Screens/BootScreen/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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
            home: const MyHomePage(),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}

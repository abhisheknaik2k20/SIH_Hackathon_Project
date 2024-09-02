import 'package:codestore/Animations/light_to_dark.dart';
import 'package:codestore/Screens/BootScreen/my_home_page.dart';
import 'package:codestore/Screens/IntroScreen/intro_screen.dart';
import 'package:codestore/Screens/pptx/pptfetcher.dart';
import 'package:codestore/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  _preloadLottieAnimations();
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
            home: PowerPointList(),

            ///FirebaseAuth.instance.currentUser == null
            ///? CodeStoreIntroScreen(onDone: () {})
            ///: const MyHomePage(),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}

Future<void> _preloadLottieAnimations() async {
  await Future.wait([
    rootBundle.loadString('assets/lottie/welcome.json'),
    rootBundle.loadString('assets/lottie/personalized_learning.json'),
    rootBundle.loadString('assets/lottie/skill.json'),
    rootBundle.loadString('assets/lottie/community.json'),
  ]);
}

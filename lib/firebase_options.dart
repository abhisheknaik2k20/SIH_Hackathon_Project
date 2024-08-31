// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBK_FcaLHs4h3Ef5ZCZs16FfiBIUAHa1Zo',
    appId: '1:461205043846:web:5c872b935569f4fa37af07',
    messagingSenderId: '461205043846',
    projectId: 'codestore-38a40',
    authDomain: 'codestore-38a40.firebaseapp.com',
    storageBucket: 'codestore-38a40.appspot.com',
    measurementId: 'G-402MMY8BQE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJs3Er6RC71YBU5v8s6U4uQh4Ka9CICjY',
    appId: '1:461205043846:android:4e842add6e0a69e337af07',
    messagingSenderId: '461205043846',
    projectId: 'codestore-38a40',
    storageBucket: 'codestore-38a40.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCIkXESrzLptq6xbkLoSCP9zOg8D9VOyTM',
    appId: '1:461205043846:ios:3f27bca36d3d9cf837af07',
    messagingSenderId: '461205043846',
    projectId: 'codestore-38a40',
    storageBucket: 'codestore-38a40.appspot.com',
    iosClientId: '461205043846-b2f6hm388g0q4cilsb0afr6hn2a6eh04.apps.googleusercontent.com',
    iosBundleId: 'com.example.codestore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCIkXESrzLptq6xbkLoSCP9zOg8D9VOyTM',
    appId: '1:461205043846:ios:544b88a5dbf67c4737af07',
    messagingSenderId: '461205043846',
    projectId: 'codestore-38a40',
    storageBucket: 'codestore-38a40.appspot.com',
    iosClientId: '461205043846-7n0up5ti6r014j8sjkkq600okn0qcs4b.apps.googleusercontent.com',
    iosBundleId: 'com.example.codestore.RunnerTests',
  );
}

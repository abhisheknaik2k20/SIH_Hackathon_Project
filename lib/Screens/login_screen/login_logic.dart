// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codestore/Screens/BootScreen/my_home_page.dart';
import 'package:codestore/Screens/login_screen/mail_verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> emailpassLogin(String email, String password, BuildContext context,
    String selectedUserType) async {
  showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()));
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(e.code),
      backgroundColor: Colors.red,
    ));
  }
  Navigator.of(context).pop();
}

Future<void> emailpassSignup(
  String email,
  String password,
  String phone,
  BuildContext context,
  String selectedUserType,
) async {
  showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()));
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('users').doc(user?.uid).set(
      {
        'name': FirebaseAuth.instance.currentUser!.displayName,
        'email': email,
        'userType': selectedUserType,
        'phone': phone,
      },
    );
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => MailVerificationScreen()),
    );
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(e.code),
      backgroundColor: Colors.red,
    ));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('An error occurred, please try again.'),
      backgroundColor: Colors.red,
    ));
  }
}

Future<void> implementGoogleSignIn(
    BuildContext context, String selectedUserType) async {
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  try {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    await googleSignIn.signOut();
    final GoogleSignInAccount? gUser = await googleSignIn.signIn();
    if (gUser == null) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Sign-in canceled'),
        backgroundColor: Colors.orange,
      ));
      return;
    }
    final GoogleSignInAuthentication gAuth = await gUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(
      {
        'name': FirebaseAuth.instance.currentUser!.displayName ?? "null",
        'email': FirebaseAuth.instance.currentUser!.email ?? "null",
        'userType': selectedUserType,
        'phone': FirebaseAuth.instance.currentUser!.phoneNumber ?? "null",
      },
    );
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MyHomePage()),
      (Route<dynamic> route) => false,
    );
  } on FirebaseAuthException catch (e) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Firebase Auth Error: ${e.code}'),
      backgroundColor: Colors.red,
    ));
  } catch (e) {
    print('Error during Google Sign-In: $e');
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('An error occurred: $e'),
      backgroundColor: Colors.red,
    ));
  }
}

Future<UserCredential?> gitHubSignIn(
    BuildContext context, String selectedUserType) async {
  try {
    final githubAuthProvider = GithubAuthProvider();
    githubAuthProvider.addScope('read:user');
    githubAuthProvider.addScope('user:email');
    githubAuthProvider.setCustomParameters({
      'allow_signup': 'true',
    });

    try {
      showDialog(
          context: context,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()));
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(
        {
          'name': FirebaseAuth.instance.currentUser!.displayName ?? "null",
          'email': FirebaseAuth.instance.currentUser!.email ?? "null",
          'userType': selectedUserType,
          'phone': FirebaseAuth.instance.currentUser!.phoneNumber ?? "null",
        },
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MyHomePage()),
        (Route<dynamic> route) => false,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.code), backgroundColor: Colors.red));
    }
  } catch (error) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(error.toString()),
      backgroundColor: Colors.red,
    ));
  }
  return null;
}

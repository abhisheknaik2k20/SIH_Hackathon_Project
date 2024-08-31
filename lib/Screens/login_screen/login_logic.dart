// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
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
        'email': email,
        'userType': selectedUserType,
        'phone': phone,
      },
    );
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Account created successfully!'),
      backgroundColor: Colors.green,
    ));
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
  } finally {
    Navigator.of(context).pop();
  }
}

Future<void> implementGoogleSignIn() async {
  final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication gAuth = await gUser!.authentication;
  final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken, idToken: gAuth.idToken);
  UserCredential user =
      await FirebaseAuth.instance.signInWithCredential(credential);
  print(user);
}

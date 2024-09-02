// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:android_intent_plus/flag.dart';
import 'package:codestore/Screens/BootScreen/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:android_intent_plus/android_intent.dart';

class MailVerificationScreen extends StatefulWidget {
  const MailVerificationScreen({super.key});

  @override
  _MailVerificationScreenState createState() => _MailVerificationScreenState();
}

class _MailVerificationScreenState extends State<MailVerificationScreen>
    with SingleTickerProviderStateMixin {
  final auth = FirebaseAuth.instance;
  User? user;
  Timer? timer;
  bool isEmailVerified = false;
  bool canResendEmail = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    isEmailVerified = user?.emailVerified ?? false;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
            .animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _animationController.forward();
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    await auth.currentUser?.reload();
    setState(() {
      isEmailVerified = auth.currentUser?.emailVerified ?? false;
    });

    if (isEmailVerified) {
      timer?.cancel();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Email verified successfully! Redirecting...')),
      );
      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => MyHomePage()),
      );
    }
  }

  Future<void> sendVerificationEmail() async {
    try {
      await user?.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 60));
      setState(() => canResendEmail = true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending email: $e')),
      );
    }
  }

  Future<void> openGmail() async {
    if (Platform.isAndroid) {
      const AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: 'android.intent.category.APP_EMAIL',
        flags: [
          Flag.FLAG_ACTIVITY_NEW_TASK
        ], // Open in a new task (similar to a new window)
      );

      try {
        await intent.launch();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error launching Gmail: $e',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Gmail can only be opened on Android devices.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              _buildHeader(colors),
              const SizedBox(height: 40),
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Column(
                        children: [
                          _buildVerificationStatus(colors),
                          const SizedBox(height: 24),
                          _buildResendEmail(colors),
                          const SizedBox(height: 16),
                          _buildOpenGmailButton(colors),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verify Your Email',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: colors.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'We\'ve sent a verification email to ${user?.email}',
          style: TextStyle(
            fontSize: 14,
            color: colors.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildVerificationStatus(ColorScheme colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isEmailVerified
            ? Colors.green.withOpacity(0.1)
            : Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            isEmailVerified ? Icons.check_circle : Icons.access_time,
            color: isEmailVerified ? Colors.green : Colors.orange,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              isEmailVerified
                  ? 'Email verified successfully!'
                  : 'Waiting for email verification...',
              style: TextStyle(
                color: colors.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResendEmail(ColorScheme colors) {
    return Column(
      children: [
        Text(
          'Didn\'t receive the verification email?',
          style: TextStyle(color: colors.onSurface.withOpacity(0.7)),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: canResendEmail ? sendVerificationEmail : null,
          style: ElevatedButton.styleFrom(
            foregroundColor: colors.onPrimary,
            backgroundColor: colors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
          child: Text(
            canResendEmail ? 'Resend Email' : 'Wait before resending',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildOpenGmailButton(ColorScheme colors) {
    return ElevatedButton.icon(
      onPressed: openGmail,
      icon: const Icon(Icons.mail),
      label: const Text('Open Gmail'),
      style: ElevatedButton.styleFrom(
        foregroundColor: colors.onPrimary,
        backgroundColor: colors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
    );
  }
}

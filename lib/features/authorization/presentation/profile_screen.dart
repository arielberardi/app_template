import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthProfileScreen extends StatelessWidget {
  const AuthProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      actions: [
        SignedOutAction((context) => context.go('/home')),
      ],
    );
  }
}

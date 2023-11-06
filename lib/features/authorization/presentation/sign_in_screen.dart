import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthSignInScreen extends StatelessWidget {
  const AuthSignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      actions: [
        AuthStateChangeAction<SignedIn>((context, _) => context.go('/home')),
      ],
    );
  }
}

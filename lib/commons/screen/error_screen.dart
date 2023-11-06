import 'package:app_template/constants/app_sizes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen(this.error, {super.key});

  final GoException? error;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/error_page.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            kDebugMode ? error.toString() : '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.normal,
              decoration: TextDecoration.none,
            ),
          ),
          gapH32,
          ElevatedButton(
            onPressed: () => context.go('/home'),
            child: const Text('Go Home'),
          ),
          gapH32,
        ],
      ),
    );
  }
}

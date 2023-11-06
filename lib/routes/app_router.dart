import 'package:app_template/commons/screen/error_screen.dart';
import 'package:app_template/features/authorization/data/auth_repository.dart';
import 'package:app_template/features/authorization/presentation/profile_screen.dart';
import 'package:app_template/features/authorization/presentation/sign_in_screen.dart';
import 'package:app_template/features/onboarding/data/onboarding_repository.dart';
import 'package:app_template/features/onboarding/presentation/onboarding_screen.dart';
import 'package:app_template/features/template/presentation/home_screen.dart';
import 'package:app_template/routes/scaffold_with_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _profileNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final onboardingRepository = ref.watch(onboardingRepositoryProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    redirect: (context, state) {
      if (!onboardingRepository.isOnboardingCompleted()) {
        return '/onboarding';
      }

      if (!authRepository.isSignedIn()) {
        return '/sign_in';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/sign_in',
        name: 'sign_in',
        builder: (context, state) => const AuthSignInScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => ScaffoldWithNavBar(
          navigationShell: navigationShell,
        ),
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              GoRoute(
                path: '/profile',
                name: 'profile',
                builder: (context, state) => const AuthProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => ErrorScreen(state.error),
  );
}

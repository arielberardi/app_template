import 'package:app_template/features/authorization/data/auth_repository.dart';
import 'package:app_template/features/onboarding/data/onboarding_repository.dart';
import 'package:app_template/features/theme/data/theme_repository.dart';
import 'package:app_template/features/theme/presentation/theme_controller.dart';
import 'package:app_template/features/remote_cfg/data/remote_cfg_repository.dart';
import 'package:app_template/firebase_options.dart';
import 'package:app_template/routes/app_router.dart';
import 'package:app_template/themes/dark_theme.dart';
import 'package:app_template/themes/light_theme.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_facebook/firebase_ui_oauth_facebook.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env file
  await dotenv.load(fileName: ".env");

  // Setup shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();

  // Setup Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Setup Firebae UI Auth
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    GoogleProvider(clientId: dotenv.env['GOOGLE_CLIENT_ID'] ?? ''),
    FacebookProvider(clientId: dotenv.env['FACEBOOK_APP_ID'] ?? '')
  ]);

  // Setup Firebase Remote Config (Enabled if you are using it)
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(hours: 1),
  ));

  await FirebaseRemoteConfig.instance.fetchAndActivate();

  runApp(ProviderScope(
    overrides: [
      onboardingRepositoryProvider.overrideWithValue(
        OnboardingRepository(sharedPreferences),
      ),
      authRepositoryProvider.overrideWithValue(
        AuthRepository(FirebaseAuth.instance),
      ),
      themeRepositoryProvider.overrideWithValue(
        ThemeRepository(sharedPreferences),
      ),
      remoteCfgRepositoryProvider.overrideWithValue(
        RemoteCfgRepository(FirebaseRemoteConfig.instance),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final themeMode = ref.watch(themeControllerProvider);

    return MaterialApp.router(
      title: 'Flutter Template',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: goRouter,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode.value,
    );
  }
}

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_repository.g.dart';

class OnboardingRepository {
  OnboardingRepository(this.sharedPreferences);

  final SharedPreferences sharedPreferences;
  final String onboardingKey = 'onboarding_completed';

  Future<void> setOnboardingCompleted() async {
    await sharedPreferences.setBool(onboardingKey, true);
  }

  bool isOnboardingCompleted() {
    return sharedPreferences.getBool(onboardingKey) ?? false;
  }
}

@Riverpod(keepAlive: true)
OnboardingRepository onboardingRepository(OnboardingRepositoryRef ref) {
  // We use UnimplementedError as the sharedPreferences are not available
  // at the startup of the app so we rely on Dependency Override from riverpod
  // to set the value for this provider.
  // Which is going to be OnboardingRepository(sharedPreferences)
  throw UnimplementedError();
}

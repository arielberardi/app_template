import 'package:app_template/features/onboarding/data/onboarding_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_controller.g.dart';

@riverpod
class OnboardingController extends _$OnboardingController {
  @override
  FutureOr<void> build() {}

  Future<void> completeOnboarding() async {
    final repository = ref.watch(onboardingRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(repository.setOnboardingCompleted);
  }
}

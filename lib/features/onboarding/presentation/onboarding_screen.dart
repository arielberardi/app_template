import 'package:app_template/features/onboarding/presentation/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  Widget getDoneButtonWidget(BuildContext context, bool isLoading) {
    if (isLoading) {
      return const SizedBox(
        height: 8,
        child: CircularProgressIndicator.adaptive(),
      );
    }

    return Text(AppLocalizations.of(context)!.page_onboarding_done);
  }

  Future<void> onOnboardingDone(
    BuildContext context,
    WidgetRef ref,
    bool isLoading,
  ) async {
    if (isLoading) {
      return;
    }

    await ref.read(onboardingControllerProvider.notifier).completeOnboarding();

    if (context.mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);

    return IntroductionScreen(
      pages: <PageViewModel>[
        PageViewModel(title: 'Onboarding', body: '1'),
        PageViewModel(title: 'Onboarding', body: '2'),
      ],
      showSkipButton: true,
      showNextButton: true,
      skip: Text(AppLocalizations.of(context)!.page_onboarding_skip),
      done: getDoneButtonWidget(context, state.isLoading),
      next: Text(AppLocalizations.of(context)!.page_onboarding_next),
      onDone: () => onOnboardingDone(context, ref, state.isLoading),
    );
  }
}

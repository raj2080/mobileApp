import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/splash_state.dart';
import '../../domain/entities/app_config.dart';

final splashProvider = StateNotifierProvider<SplashNotifier, SplashState>((ref) {
  return SplashNotifier();
});

class SplashNotifier extends StateNotifier<SplashState> {
  SplashNotifier() : super(const SplashState.initial());

  Future<void> initializeApp() async {
    state = const SplashState.loading();

    try {
      // Simulate initialization delay
      await Future.delayed(const Duration(seconds: 2));

      // Mock app configuration
      const config = AppConfig(
        appVersion: '1.0.0',
        isForceUpdate: false,
        isMaintenance: false,
        maintenanceMessage: null,
      );

      state = SplashState.configured(config);

      // Check if user is logged in (we'll implement this later)
      const bool isLoggedIn = false;

      await Future.delayed(const Duration(seconds: 1));

      if (isLoggedIn) {
        state = const SplashState.navigateToHome();
      } else {
        state = const SplashState.navigateToAuth();
      }
    } catch (e) {
      state = SplashState.error(e.toString());
    }
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/splash_state.dart';
import '../../domain/entities/app_config.dart';

// Add provider to store app configuration
final appConfigProvider = StateProvider<AppConfig?>((ref) => null);

final splashProvider = StateNotifierProvider<SplashNotifier, SplashState>((ref) {
  return SplashNotifier(ref);
});

class SplashNotifier extends StateNotifier<SplashState> {
  final Ref _ref;

  SplashNotifier(this._ref) : super(const SplashState.initial());

  Future<void> initializeApp() async {
    state = const SplashState.loading();

    try {
      // Minimum splash screen duration
      final minimumSplashDuration = Future.delayed(
        const Duration(seconds: 2),
      );

      // TODO: Replace with actual API call
      final config = AppConfig(
        appVersion: '1.0.0',
        isForceUpdate: false,
        isMaintenance: false,
        maintenanceMessage: null,
      );

      // Validate config
      if (config.appVersion.isEmpty) {
        throw Exception('Invalid app configuration: Missing version');
      }

      // Store config for later use
      _ref.read(appConfigProvider.notifier).state = config;
      state = SplashState.configured(config);

      // Check if maintenance mode is on
      if (config.isMaintenance) {
        state = SplashState.error(
          config.maintenanceMessage ?? 'App is under maintenance',
        );
        return;
      }

      // Check if force update is required
      if (config.isForceUpdate) {
        state = const SplashState.error('App update required');
        return;
      }

      // Ensure minimum splash duration
      await minimumSplashDuration;

      // TODO: Replace with actual authentication check
      const bool isLoggedIn = false;

      // Navigate based on auth status
      if (isLoggedIn) {
        state = const SplashState.navigateToHome();
      } else {
        state = const SplashState.navigateToAuth();
      }
    } catch (e) {
      state = SplashState.error('Failed to initialize app: ${e.toString()}');
    }
  }
}
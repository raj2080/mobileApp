import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blushstore_project/app/themes/app_theme.dart';
import 'package:blushstore_project/app/navigator/app_router.dart';
import 'package:blushstore_project/features/splash/presentation/view/splash_screen.dart';
import 'package:blushstore_project/features/splash/presentation/providers/splash_provider.dart';
import 'package:blushstore_project/features/splash/presentation/state/splash_state.dart'; // Add this import
import 'package:blushstore_project/features/auth/presentation/view/login_screen.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to splash state changes
    ref.listen<SplashState>(splashProvider, (previous, current) {
      // Handle null safety with if-null operator
      current?.when(
        initial: () {},
        loading: () {},
        configured: (config) {},
        navigateToAuth: () {
          AppRouter.navigatorKey.currentState?.pushReplacement(
            MaterialPageRoute(
              builder: (_) => const LoginScreen(),
            ),
          );
        },
        navigateToHome: () {
          // TODO: Will implement home navigation later
        },
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    });

    return MaterialApp(
      title: 'Blush Store',
      theme: AppTheme.lightTheme,
      navigatorKey: AppRouter.navigatorKey,
      home: const SplashScreen(),
    );
  }
}
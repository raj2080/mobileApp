import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blushstore_project/app/themes/app_theme.dart';
import 'package:blushstore_project/app/navigator/app_router.dart';
import 'package:blushstore_project/features/splash/presentation/view/splash_screen.dart';
import 'package:blushstore_project/features/splash/presentation/providers/splash_provider.dart';
import 'package:blushstore_project/features/splash/presentation/state/splash_state.dart';
import 'package:blushstore_project/features/auth/presentation/view/login_screen.dart';
import 'package:blushstore_project/features/auth/presentation/view/signup_screen.dart';
import 'package:blushstore_project/features/home/presentation/view/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:blushstore_project/app/constants/app_constants.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to splash state changes
    ref.listen<SplashState>(splashProvider, (previous, current) {
      current?.whenOrNull(
        initial: () {
          // Initialize user data in Hive
          _initializeUserData();
        },
        loading: () {},
        configured: (config) {},
        navigateToAuth: () {
          AppRouter.replaceTo('/login');
        },
        navigateToHome: () {
          AppRouter.replaceTo('/home');
        },
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              duration: const Duration(seconds: 3),
              action: SnackBarAction(
                label: 'Dismiss',
                textColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );
        },
      );
    });

    return MaterialApp(
      title: 'Blush Store',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      navigatorKey: AppRouter.navigatorKey,
      home: const SplashScreen(),
      onGenerateRoute: (settings) {
        // Pass route arguments if any
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            switch (settings.name) {
              case '/':
                return const SplashScreen();
              case '/login':
                return const LoginScreen();
              case '/signup':
                return const SignupScreen();
              case '/home':
                return const HomeScreen();
              default:
                return const SplashScreen();
            }
          },
        );
      },
    );
  }

  Future<void> _initializeUserData() async {
    try {
      final userBox = Hive.box(AppConstants.userBox);

      // Set current timestamp and user if not exists
      if (!userBox.containsKey('lastLoginTime')) {
        await userBox.put('lastLoginTime', '2025-03-04 07:06:04');
      }
      if (!userBox.containsKey('currentUser')) {
        await userBox.put('currentUser', '2025raj');
      }

      // Update last login time if user exists
      if (userBox.get('currentUser') != null) {
        await userBox.put('lastLoginTime', '2025-03-04 07:06:04');
      }
    } catch (e) {
      debugPrint('Error initializing user data: $e');
    }
  }
}

// Add route name constants
class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';

  // Prevent instantiation
  const AppRoutes._();
}
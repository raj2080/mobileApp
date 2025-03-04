import 'package:flutter/material.dart';
import 'package:blushstore_project/features/auth/presentation/view/login_screen.dart';
import 'package:blushstore_project/features/auth/presentation/view/signup_screen.dart';
import 'package:blushstore_project/features/home/presentation/view/home_screen.dart';
import 'package:blushstore_project/features/splash/presentation/view/splash_screen.dart';

class AppRouter {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Basic navigation methods
  static Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> replaceTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  static void pop([dynamic result]) {
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop(result);
    }
  }

  // Additional navigation methods
  static Future<dynamic> pushAndRemoveUntil(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
          (route) => false,
      arguments: arguments,
    );
  }

  static Future<dynamic> maybePop([dynamic result]) {
    return navigatorKey.currentState!.maybePop(result);
  }

  // Route specific navigation methods
  static Future<void> navigateToLogin() async {
    await replaceTo('/login');
  }

  static Future<void> navigateToSignup() async {
    await navigateTo('/signup');
  }

  static Future<void> navigateToHome() async {
    await pushAndRemoveUntil('/home');
  }

  // Route generation
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case '/login':
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );

      case '/signup':
        return MaterialPageRoute(
          builder: (_) => const SignupScreen(),
          settings: settings,
        );

      case '/home':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: const Text('Error'),
            ),
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
          settings: settings,
        );
    }
  }

  // Helper methods
  static bool canPop() {
    final NavigatorState? navigator = navigatorKey.currentState;
    return navigator != null && navigator.canPop();
  }

  static BuildContext? get context => navigatorKey.currentContext;

  // Error handling wrapper
  static Future<T?> handleNavigation<T>(Future<T> Function() navigationCall) async {
    try {
      return await navigationCall();
    } catch (e) {
      debugPrint('Navigation error: $e');
      return null;
    }
  }
}

// Route names constants
class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
}
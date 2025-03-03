import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blushstore_project/app/themes/app_theme.dart';
import 'package:blushstore_project/app/navigator/app_router.dart';
import 'package:blushstore_project/features/splash/presentation/view/splash_screen.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Blush Store',
      theme: AppTheme.lightTheme,
      navigatorKey: AppRouter.navigatorKey,
      home: const SplashScreen(),
    );
  }
}
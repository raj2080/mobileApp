import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:blushstore_project/app/app.dart';
import 'package:blushstore_project/app/constants/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Open Hive boxes
  await Future.wait([
    Hive.openBox(AppConstants.userBox),
    Hive.openBox(AppConstants.productBox),
    Hive.openBox(AppConstants.cartBox),
    Hive.openBox(AppConstants.orderBox),
  ]);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
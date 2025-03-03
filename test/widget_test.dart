import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blushstore_project/app/app.dart'; // Update the import path

void main() {
  testWidgets('Splash screen test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // Verify that splash screen shows up
    expect(find.byType(FlutterLogo), findsOneWidget); // Since we're using FlutterLogo as placeholder

    // Optional: Wait for splash screen animation
    await tester.pump(const Duration(seconds: 3));
  });
}
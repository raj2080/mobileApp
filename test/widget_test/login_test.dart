import 'package:blushstore/app/app.dart';
import 'package:blushstore/features/auth/presentation/view/login_view.dart';
import 'package:blushstore/features/auth/presentation/widgets/LoginButton.dart';
import 'package:blushstore/features/home/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('LoginView Instrumented Test', () {
    testWidgets('Login form validation and navigation to HomeView', (WidgetTester tester) async {
      // Launch the app
      await tester.pumpWidget(const App());

      // Verify LoginView is displayed
      expect(find.byType(LoginView), findsOneWidget);

      // Enter invalid email and password
      await tester.enterText(find.byType(TextFormField).first, 'invalid_email');
      await tester.enterText(find.byType(TextFormField).last, '123');
      await tester.tap(find.byType(LoginButton));

      // Wait for validation error messages
      await tester.pump();

      // Check validation errors are shown
      expect(find.text('Please enter a valid email address'), findsOneWidget);
      expect(find.text('Password must be at least 6 characters'), findsOneWidget);

      // Enter valid email and password
      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.enterText(find.byType(TextFormField).last, 'password');
      await tester.tap(find.byType(LoginButton));

      // Wait for the login process and navigation to HomeView
      await tester.pumpAndSettle();

      // Verify navigation to HomeView
      expect(find.byType(HomeView), findsOneWidget);
    });
  });
}

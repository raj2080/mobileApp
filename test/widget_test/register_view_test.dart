import 'package:blushstore/app/app.dart';
import 'package:blushstore/features/auth/presentation/view/login_view.dart';
import 'package:blushstore/features/auth/presentation/view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('RegisterView Instrumented Test', () {
    testWidgets('Registration form validation and navigation to LoginView', (WidgetTester tester) async {
      // Launch the app
      await tester.pumpWidget(const App());

      // Navigate to RegisterView
      await tester.tap(find.text('Register Now'));
      await tester.pumpAndSettle();

      // Verify RegisterView is displayed
      expect(find.byType(RegisterView), findsOneWidget);

      // Enter invalid email and phone number
      await tester.enterText(find.byType(TextFormField).at(0), 'John');
      await tester.enterText(find.byType(TextFormField).at(1), 'Doe');
      await tester.enterText(find.byType(TextFormField).at(2), 'invalid_email');
      await tester.enterText(find.byType(TextFormField).at(3), '123456');
      await tester.enterText(find.byType(TextFormField).at(4), 'password');
      await tester.enterText(find.byType(TextFormField).at(5), 'different_password');
      await tester.tap(find.byType(ElevatedButton));

      // Wait for validation error messages
      await tester.pump();

      // Check validation errors are shown
      expect(find.text('Please enter a valid email address'), findsOneWidget);
      expect(find.text('Please enter a valid 10-digit phone number'), findsOneWidget);
      expect(find.text('Passwords do not match'), findsOneWidget);

      // Enter valid data
      await tester.enterText(find.byType(TextFormField).at(2), 'test@example.com');
      await tester.enterText(find.byType(TextFormField).at(3), '1234567890');
      await tester.enterText(find.byType(TextFormField).at(5), 'password');
      await tester.tap(find.byType(ElevatedButton));

      // Wait for the registration process and navigation to LoginView
      await tester.pumpAndSettle();

      // Verify navigation to LoginView
      expect(find.byType(LoginView), findsOneWidget);
    });
  });
}

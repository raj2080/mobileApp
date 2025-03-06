import 'package:blushstore/app/app.dart';
import 'package:blushstore/features/home/presentation/view/pages/ChangePasswordPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Initialize the integration test framework.
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('ChangePasswordPage Instrumented Test', () {
    testWidgets('Change password form validation and success', (WidgetTester tester) async {
      // Launch the app.
      await tester.pumpWidget(const App());

      // Navigate to ChangePasswordPage (assuming a route or a navigation button exists).
      await tester.tap(find.text('Change Password')); // Replace with the actual way to open the ChangePasswordPage.
      await tester.pumpAndSettle();

      // Verify that ChangePasswordPage is displayed.
      expect(find.byType(ChangePasswordPage), findsOneWidget);

      // Enter an invalid current password.
      await tester.enterText(find.byKey(Key('current_password')), 'short');
      await tester.enterText(find.byKey(Key('new_password')), 'newpassword');
      await tester.enterText(find.byKey(Key('confirm_password')), 'newpassword');
      await tester.tap(find.text('Change Password'));

      // Wait for validation error messages.
      await tester.pump();

      // Check that validation errors are shown.
      expect(find.text('Please enter a valid current password'), findsOneWidget);

      // Enter valid passwords.
      await tester.enterText(find.byKey(Key('current_password')), 'currentpassword');
      await tester.enterText(find.byKey(Key('new_password')), 'newpassword');
      await tester.enterText(find.byKey(Key('confirm_password')), 'newpassword');
      await tester.tap(find.text('Change Password'));

      // Wait for the change password process and the success message.
      await tester.pumpAndSettle();

      // Verify that a success message is displayed.
      expect(find.text('Password changed successfully'), findsOneWidget);
    });
  });
}

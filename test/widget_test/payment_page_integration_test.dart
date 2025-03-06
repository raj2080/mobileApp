import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('PaymentPage Instrumented Test', () {
    testWidgets('Confirm order through PaymentPage', (WidgetTester tester) async {
      // Launch the app

      await tester.pumpAndSettle();

      // Navigate to PaymentPage (Assuming you have a route or button that leads to it)
      await tester.tap(find.byKey(Key('goToPaymentButton')));
      await tester.pumpAndSettle();

      // Fill in the form fields
      await tester.enterText(find.byType(TextFormField).at(0), '123 Main St');
      await tester.enterText(find.byType(TextFormField).at(1), '9876543210');
      await tester.enterText(find.byType(TextFormField).at(2), 'Kathmandu');
      await tester.enterText(find.byType(TextFormField).at(3), 'Bagmati');
      await tester.enterText(find.byType(TextFormField).at(4), 'Nepal');
      await tester.enterText(find.byType(TextFormField).at(5), '12345');

      // Select payment method
      await tester.tap(find.text('Cash on Delivery'));
      await tester.pumpAndSettle();

      // Tap the confirm button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Check for confirmation message
      expect(find.text('Order has been confirmed!'), findsOneWidget);
    });
  });
}

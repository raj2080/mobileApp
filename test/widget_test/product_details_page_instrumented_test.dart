import 'package:blushstore/features/home/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('ProductDetailsPage Instrumented Test', () {
    testWidgets('Submit a review on ProductDetailsPage', (WidgetTester tester) async {
      // Create a mock product
      final product = ProductEntity(
        id: '1',
        productName: 'Sample Product',
        productDescription: 'This is a sample product description.',
        productPrice: 1000,
        productImage: 'sample_image.png',
        productCategory: 'AED',
        createdAt: '',
      );

      await tester.pumpAndSettle();

      // Navigate to ProductDetailsPage (assuming there's a button to navigate)
      await tester.tap(find.byKey(Key('navigateToProductDetails')));
      await tester.pumpAndSettle();

      // Select a rating
      await tester.tap(find.byIcon(Icons.star).first);
      await tester.pumpAndSettle();

      // Enter username
      await tester.enterText(find.byKey(Key('usernameField')), 'TestUser');
      await tester.pumpAndSettle();

      // Enter review text
      await tester.enterText(find.byKey(Key('reviewField')), 'This is a test review.');
      await tester.pumpAndSettle();

      // Submit the review
      await tester.tap(find.byKey(Key('submitReviewButton')));
      await tester.pumpAndSettle();

      // Verify that the review was added
      expect(find.text('This is a test review.'), findsOneWidget);
      expect(find.text('TestUser'), findsOneWidget);
    });
  });
}

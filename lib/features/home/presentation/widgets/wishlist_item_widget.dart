import 'package:flutter/material.dart';

class WishlistItemWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final VoidCallback onMoveToCart;

  const WishlistItemWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.onMoveToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            // Text Information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple, // Use purple for title
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Price: Npr.$price',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.amber[700], // Use amber for price
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            // Move to Cart Button
            ElevatedButton(
              onPressed: onMoveToCart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber, // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                elevation: 5,
              ),
              child: const Row(
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 16, color: Colors.white),
                  SizedBox(width: 4.0),
                  Text(
                    'Move',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Amber color for text
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

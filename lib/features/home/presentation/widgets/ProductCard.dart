import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../order/presentation/view/PaymentPage.dart';
import '../../domain/entity/product_entity.dart';
import 'dart:convert';
import 'dart:typed_data';

import '../Notifier/WishlistNotifier.dart';


class ProductCard extends ConsumerWidget {
  final ProductEntity product;
  final bool isInWishlist;
  final VoidCallback onWishlistToggle;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.isInWishlist,
    required this.onWishlistToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void _proceedToPayment(double itemPrice) {
      const shipping = 50.0;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(
            shipping: shipping,

            products: [product], // Pass the product details here
          ),
        ),
      );
    }

    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 5,
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.grey[200],
                    image: _buildProductImage("http://10.0.2.2:3001/products/${product.productImage}"),
                  ),
                  child: product.productImage.isEmpty
                      ? Center(
                    child: Icon(
                      Icons.image,
                      color: Colors.grey[400],
                      size: 50,
                    ),
                  )
                      : null,
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                product.productName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8.0),
              Text(
                product.productDescription,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8.0),
              Text(
                'Npr.${product.productPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12.0), // Space between price and buttons
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      isInWishlist ? Icons.favorite : Icons.favorite_border,
                      color: isInWishlist ? Colors.red : Colors.grey,
                      size: 24,
                    ),
                    onPressed: onWishlistToggle,
                  ),
                  const SizedBox(width: 8.0), // Space between wishlist button and cart button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _proceedToPayment(double.parse("${product.productPrice}"));
                        // Add to cart functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                      ),
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  DecorationImage? _buildProductImage(String imageUrl) {
    if (imageUrl.isEmpty) {
      return null;
    }

    // Check if image URL is a base64-encoded image
    if (imageUrl.startsWith('data:image/')) {
      try {
        final base64String = imageUrl.split(',').last;
        final decodedBytes = base64Decode(base64String);
        return DecorationImage(
          image: Image.memory(decodedBytes).image,
          fit: BoxFit.cover,
        );
      } catch (e) {
        // Handle invalid base64 string
        print('Invalid base64 string: $e');
        return null;
      }
    }

    // Load image from network URL
    try {
      final uri = Uri.parse(imageUrl);
      if (uri.isAbsolute) {
        return DecorationImage(
          image: CachedNetworkImageProvider(imageUrl),
          fit: BoxFit.cover,
        );
      }
    } catch (e) {
      // Handle invalid URL
      print('Invalid URL: $e');
      return null;
    }

    return null;
  }
}

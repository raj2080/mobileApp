import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/wishlist_item_widget.dart';
import '../../widgets/wishlist_summary_widget.dart';


class WishlistPage extends ConsumerStatefulWidget {
  const WishlistPage({super.key});

  @override
  ConsumerState<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends ConsumerState<WishlistPage> {
  final List<Map<String, String>> _wishlistItems = [
    {
      'imageUrl': 'https://via.placeholder.com/100',
      'title': 'Wishlist Item 1',
      'price': '15.00',
    },
    {
      'imageUrl': 'https://via.placeholder.com/100',
      'title': 'Wishlist Item 2',
      'price': '25.00',
    },
    {
      'imageUrl': 'https://via.placeholder.com/100',
      'title': 'Wishlist Item 3',
      'price': '35.00',
    },
  ];

  void _moveToCart(int index) {
    setState(() {
      // Logic to move item to cart
      _wishlistItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Wishlist'),
        backgroundColor: Colors.amber,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _wishlistItems.length,
                itemBuilder: (context, index) {
                  final item = _wishlistItems[index];
                  return WishlistItemWidget(
                    imageUrl: item['imageUrl']!,
                    title: item['title']!,
                    price: item['price']!,
                    onMoveToCart: () => _moveToCart(index),
                  );
                },
              ),
            ),
            WishlistSummaryWidget(
              itemCount: _wishlistItems.length,
              totalValue: _wishlistItems.fold(
                0.0,
                    (previousValue, item) => previousValue + double.parse(item['price']!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

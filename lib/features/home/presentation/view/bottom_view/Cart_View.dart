import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/cart_item_widget.dart';
import '../../widgets/cart_summary_widget.dart';


class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  late ScrollController _scrollController;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final List<Map<String, String>> _cartItems = [
    {
      'imageUrl': 'https://via.placeholder.com/100',
      'title': 'Product 1',
      'price': '20.00',
    },
    {
      'imageUrl': 'https://via.placeholder.com/80',
      'title': 'Product 2',
      'price': '25.00',
    },
    {
      'imageUrl': 'https://via.placeholder.com/80',
      'title': 'Product 3',
      'price': '30.00',
    },
    {
      'imageUrl': 'https://via.placeholder.com/80',
      'title': 'Product 4',
      'price': '35.00',
    },
    {
      'imageUrl': 'https://via.placeholder.com/80',
      'title': 'Product 5',
      'price': '40.00',
    },
  ];

  Future<void> _refreshCart() async {

    await Future.delayed(Duration(seconds: 1));


    setState(() {});
  }

  void _proceedToPayment(double itemPrice) {
    const shipping = 50.0;
    final total = itemPrice + shipping;

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => PaymentPage(
    //       subtotal: itemPrice,
    //       shipping: shipping,
    //       total: total,
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = _cartItems.fold(
      0.0,
          (previousValue, item) => previousValue + double.parse(item['price']!),
    );
    const shipping = 50.0;
    final total = subtotal + shipping;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: Colors.amber,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _refreshCart();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshCart,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _cartItems.length,
                  itemBuilder: (context, index) {
                    final item = _cartItems[index];
                    return CartItemWidget(
                      imageUrl: item['imageUrl']!,
                      title: item['title']!,
                      price: item['price']!,
                      onRemove: () {
                        setState(() {
                          _cartItems.removeAt(index);
                        });
                      },
                      onProceedToPayment: () => _proceedToPayment(double.parse(item['price']!)),
                    );
                  },
                ),
              ),
              CartSummaryWidget(
                subtotal: subtotal,
                shipping: shipping,
                total: total,
                onCheckout: () => _proceedToPayment(subtotal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

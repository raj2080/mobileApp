import 'package:flutter/material.dart';

class CartItemWidget extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String price;
  final VoidCallback onRemove;
  final VoidCallback onProceedToPayment;

  const CartItemWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.onRemove,
    required this.onProceedToPayment,
  }) : super(key: key);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  int quantity = 1;

  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decreaseQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                widget.imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              widget.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price: Npr.${widget.price}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove, color: Colors.amber),
                      onPressed: _decreaseQuantity,
                    ),
                    Text(
                      '$quantity',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add, color: Colors.amber),
                      onPressed: _increaseQuantity,
                    ),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: widget.onRemove,
            ),
          ),
          ButtonBar(
            children: [
              TextButton(
                onPressed: widget.onProceedToPayment,
                child: const Text(
                  'Proceed to Payment',
                  style: TextStyle(color: Colors.amber),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

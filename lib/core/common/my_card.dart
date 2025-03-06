import 'package:flutter/material.dart';

import '../../app/constants/api_endpoint.dart';
import '../../features/home/domain/entity/product_entity.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key, required this.productEntity});

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: SingleChildScrollView(
          child: Row(
            children: [
              SizedBox(
                width: 88,
                child: AspectRatio(
                  aspectRatio: 0.88,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: const Color(0xFFF5F6F9), borderRadius: BorderRadius.circular(15)),
                    child: Image.network('${ApiEndpoints.productImage}${productEntity.productImage}'),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productEntity.productName,
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.amber),
                        children: [
                          TextSpan(text: "${productEntity.productPrice}", style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),

                onPressed: () => {},

                child: const Text('Add to cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

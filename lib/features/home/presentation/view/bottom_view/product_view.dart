import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/product_state.dart';
import '../../viewmodel/product_view_model.dart';

class ProductView extends ConsumerStatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductViewState();
}

class _ProductViewState extends ConsumerState<ProductView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productViewModelProvider.notifier).pagination();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productViewModelProvider);

    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (_scrollController.position.extentAfter == 0) {
            ref.read(productViewModelProvider.notifier).pagination();
          }
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Products')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // children: [
            //   const SizedBox(height: 8),
            //   Flexible(
            //     child: RefreshIndicator(
            //       color: Colors.green,
            //       onRefresh: () async {
            //         ref.read(productViewModelProvider.notifier).resetState();
            //       },
            //       child: _productList(state),
            //     ),
            //   ),
            // ],
          ),
        ),
      ),
    );
  }

  Widget _productList(ProductState state) {
    final displayedProducts = state.products ?? [];

    return ListView.builder(
      controller: _scrollController,
      itemCount: displayedProducts.length,
      itemBuilder: (context, index) {
        final product = displayedProducts[index];
        return ListTile(
          title: Text(product.productName, style: const TextStyle(fontSize: 18)),
          subtitle: Text('Price: ${product.productPrice}', style: const TextStyle(fontSize: 14)),
          trailing: IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Handle product details or any other action here
            },
          ),
        );
      },
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/product_entity.dart';

// A provider that holds the list of wishlist items
final wishlistProvider = StateNotifierProvider<WishlistNotifier, List<ProductEntity>>((ref) {
  return WishlistNotifier();
});

class WishlistNotifier extends StateNotifier<List<ProductEntity>> {
  WishlistNotifier() : super([]);

  void addToWishlist(ProductEntity product) {
    if (!state.contains(product)) {
      state = [...state, product];
    }
  }

  void removeFromWishlist(ProductEntity product) {
    state = state.where((p) => p.id != product.id).toList();
  }

  bool isInWishlist(ProductEntity product) {
    return state.any((p) => p.id == product.id);
  }
}

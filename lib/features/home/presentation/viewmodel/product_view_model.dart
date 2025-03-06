import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/product_usecase.dart';
import '../state/product_state.dart';

final productViewModelProvider = StateNotifierProvider<ProductViewModel, ProductState>((ref) {
  return ProductViewModel(productUsecase: ref.read(productUseCaseProvider));
});

class ProductViewModel extends StateNotifier<ProductState> {
  ProductViewModel({required this.productUsecase}) : super(ProductState.initial()) {
    pagination();
  }
  final ProductUseCase productUsecase;

  Future pagination() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final products = currentState.products;
    final hasReachedMax = currentState.hasReachedMax;

    if (!hasReachedMax!) {
      final result = await productUsecase.pagination(page, 10);
      result.fold((failure) => state = state.copyWith(hasReachedMax: true, isLoading: false, error: failure.error), (
        data,
      ) {
        if (data.isEmpty) {
          state = state.copyWith(hasReachedMax: true, isLoading: false);
        } else {
          state = state.copyWith(products: [...products, ...data], page: page, isLoading: false);
        }
      });
    }
  }

  Future<void> loadMoreProducts() async {
    state = ProductState.initial();
    await pagination();
  }

  refreshProducts() {}
}

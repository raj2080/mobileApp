import '../../domain/entity/product_entity.dart';

class ProductState {
  final List<ProductEntity> products;
  final bool hasReachedMax;
  final int page;
  final bool isLoading;
  final String? error;

  ProductState({
    required this.products,
    required this.hasReachedMax,
    required this.page,
    required this.isLoading,
    this.error,
  });

  factory ProductState.initial() {
    return ProductState(products: [], hasReachedMax: false, page: 0, isLoading: false, error: null);
  }

  ProductState copyWith({
    List<ProductEntity>? products,
    bool? hasReachedMax,
    int? page,
    bool? isLoading,
    String? error,
  }) {
    return ProductState(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

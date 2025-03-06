import 'package:blushstore/core/failure/failure.dart';
import 'package:blushstore/features/home/data/model/product_model.dart';
import 'package:blushstore/features/home/domain/entity/product_entity.dart';
import 'package:blushstore/features/home/domain/usecases/product_usecase.dart';
import 'package:blushstore/features/home/presentation/viewmodel/product_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';

import 'package:mockito/annotations.dart';
import 'product_test.mocks.dart';
import 'product_view_model_test.mocks.dart';

@GenerateMocks([ProductUseCase])
void main() {
  group('ProductModel Tests', () {
    const tProductModel = ProductModel(
      id: '1',
      productName: 'Example Product',
      productPrice: 0,
      productCategory: 'Electronics',
      productDescription: 'An example electronic product',
      productImage: 'image_url',
      createdAt: '2021-01-01T12:00:00Z',
    );

    const tProductEntity = ProductEntity(
      productName: 'pacifier',
      productPrice: 0,
      productCategory: 'Essential',
      productDescription: 'Baby product',
      productImage: '1719576356836-718uGZMrfuL._AC_SL1200_.jpeg',
      createdAt: '2024-06-28T12:01:18.809+00:00',
    );

    test('fromJson and toJson', () {
      // Arrange
      var jsonMap = {
        '_id': '1',
        'productName': 'Example Product',
        'productPrice': '99.99',
        'productCategory': 'Electronics',
        'productDescription': 'An example electronic product',
        'productImage': 'image_url',
        'createdAt': '2021-01-01T12:00:00Z',
      };

      // Act
      final result = ProductModel.fromJson(jsonMap);

      // Assert
      expect(result, tProductModel);
      expect(result.toJson(), jsonMap);
    });

    test('toEntity and fromEntity', () {
      // Test toEntity
      final entityResult = tProductModel.toEntity();
      expect(entityResult, tProductEntity);

      // Test fromEntity
      final fromEntityResult = tProductModel.fromEntity(tProductEntity);
      expect(fromEntityResult, tProductModel);
    });

    test('Equatable props', () {
      expect(tProductModel.props, [
        '1',
        'Example Product',
        '99.99',
        'Electronics',
        'An example electronic product',
        'image_url',
        '2021-01-01T12:00:00Z',
      ]);
    });
  });

  // ViewModel Tests
  late MockProductUseCase mockProductUseCase;
  late ProviderContainer container;

  setUp(() {
    mockProductUseCase = MockProductUseCase();
    container = ProviderContainer(
      overrides: [productUseCaseProvider.overrideWithValue(mockProductUseCase as ProductUseCase)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('Pagination should correctly handle new data', () async {
    when(mockProductUseCase.pagination(any, any)).thenAnswer((_) async => Right([/* Mocked product data here */]));

    final viewModel = container.read(productViewModelProvider.notifier);
    await viewModel.pagination();

    // Assertions to verify state changes
    final state = container.read(productViewModelProvider);
    expect(state.isLoading, isFalse);
    expect(state.products.isNotEmpty, isTrue);
    expect(state.page, equals(2)); // Assuming initial page is 1
  });

  test('Pagination should handle empty data by setting hasReachedMax', () async {
    when(mockProductUseCase.pagination(any, any)).thenAnswer((_) async => Right([]));

    final viewModel = container.read(productViewModelProvider.notifier);
    await viewModel.pagination();

    // Assertions to verify handling of empty data
    final state = container.read(productViewModelProvider);
    expect(state.hasReachedMax, isTrue);
    expect(state.isLoading, isFalse);
  });

  test('Pagination should handle errors correctly', () async {
    when(mockProductUseCase.pagination(any, any)).thenAnswer((_) async => Left(Failure(error: "Error fetching data")));

    final viewModel = container.read(productViewModelProvider.notifier);
    await viewModel.pagination();

    // Assertions to verify error handling
    final state = container.read(productViewModelProvider);
    expect(state.error, isNotNull);
    expect(state.isLoading, isFalse);
  });
}

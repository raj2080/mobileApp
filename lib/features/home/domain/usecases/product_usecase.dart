import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/product_entity.dart';
import '../repository/i_product_repository.dart';

final productUseCaseProvider = Provider.autoDispose<ProductUseCase>(
  (ref) => ProductUseCase(repository: ref.read(productRepositoryProvider)),
);

class ProductUseCase {
  final IProductRepository repository;

  ProductUseCase({required this.repository});

  Future<Either<Failure, List<ProductEntity>>> pagination(int page, int limit) {
    return repository.pagination(page, limit);
  }
}

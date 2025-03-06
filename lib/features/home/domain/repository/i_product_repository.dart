import 'package:dartz/dartz.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/product_respository.dart';
import '../entity/product_entity.dart';

final productRepositoryProvider = Provider((ref) {
  return ref.watch(productRemoteRepositoryProvider);
});

abstract class IProductRepository {
  Future<Either<Failure, List<ProductEntity>>> pagination(int page, int limit);
}

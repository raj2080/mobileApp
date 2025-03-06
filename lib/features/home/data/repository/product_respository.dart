import 'package:dartz/dartz.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/repository/i_product_repository.dart';
import '../data_source/remote/product_data_source.dart';

final productRemoteRepositoryProvider = Provider(
  (ref) => ProductRepoImpl(productRemoteDataSource: ref.read(productRemoteDatasourceProvider)),
);

class ProductRepoImpl implements IProductRepository {
  final ProductRemoteDatasource productRemoteDataSource;

  ProductRepoImpl({required this.productRemoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> pagination(int page, int limit) {
    return productRemoteDataSource.pagination(page: page, limit: limit);
  }
}

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../app/constants/api_endpoint.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/networking/remote/http_service.dart';
import '../../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../../domain/entity/product_entity.dart';
import '../../dto/get_all_products.dart';
import '../../model/product_model.dart';

final productRemoteDatasourceProvider = Provider<ProductRemoteDatasource>((ref) {
  final dio = ref.read(httpServiceProvider);
  final productApiModel = ref.read(productModelProvider);
  final userSharedPrefs = ref.read(userSharedPrefsProvider);

  return ProductRemoteDatasource(dio: dio, productModel: productApiModel, userSharedPrefs: userSharedPrefs);
});

class ProductRemoteDatasource {
  final Dio dio;
  final ProductModel productModel;
  final UserSharedPrefs userSharedPrefs;

  ProductRemoteDatasource({required this.dio, required this.productModel, required this.userSharedPrefs});

  Future<Either<Failure, List<ProductEntity>>> pagination({required int page, required int limit}) async {
    try {
      final token = await userSharedPrefs.getUserToken();
      token.fold((l) => throw Failure(error: l.error), (r) => r);
      final response = await dio.get(
        ApiEndpoints.getProducts,
        queryParameters: {'page': page, 'limit': limit},
        options: Options(headers: {'authorization': 'Bearer $token'}),
      );
      print('API Response: ${response.data}');
      print(response);
      if (response.statusCode == 201) {
        final productDto = GetAllProductsDTO.fromJson(response.data);
        return Right(productModel.toEntityList(productDto.products));
      }
      return Left(Failure(error: response.statusMessage.toString(), statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }
}

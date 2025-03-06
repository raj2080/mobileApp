import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/constants/api_endpoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/networking/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../domain/entity/OrderEntity.dart';
import '../model/order_model.dart';

final orderRemoteDatasourceProvider = Provider<OrderRemoteDatasource>((ref) {
  final dio = ref.read(httpServiceProvider);
  final orderModel = ref.read(orderModelProvider);
  final userSharedPrefs = ref.read(userSharedPrefsProvider);

  return OrderRemoteDatasource(dio: dio, orderModel: orderModel, userSharedPrefs: userSharedPrefs);
});

class OrderRemoteDatasource {
  final Dio dio;
  final OrderModel orderModel;
  final UserSharedPrefs userSharedPrefs;

  OrderRemoteDatasource({required this.dio, required this.orderModel, required this.userSharedPrefs});

  // Create a new order
  Future<Either<Failure, bool>> createOrder(OrderModel orderModel) async {
    try {
      final token = await userSharedPrefs.getUserToken();
      print(token);
      final user = token.fold((l) => throw Failure(error: l.error), (r) => r);

      print(user);

      final response = await dio.post(
        ApiEndpoints.createOrder,
        data: orderModel.toJson(),
        options: Options(headers: {'authorization': 'Bearer $user'}),
      );

      if (response.statusCode == 201) {
        print(order);
        return Right(true);
      }

      return Left(Failure(error: response.statusMessage.toString(), statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }

  // Get logged in user orders
  Future<Either<Failure, List<OrderEntity>>> getUserOrders() async {
    try {
      final token = await userSharedPrefs.getUserToken();
      // token.fold((l) => throw Failure(error: l.error), (r) => r);
      final user = token.fold((l) => throw Failure(error: l.error), (r) => r);

      final response = await dio.get(
        ApiEndpoints.getUserOrders,
        options: Options(headers: {'authorization': 'Bearer $user'}),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final orders =
            (data as List<dynamic>).map((json) => OrderModel.fromJson(json as Map<String, dynamic>)).toList();
        print("order cast${orders.cast()}");
        final orderEntities = orders.map((order) => order.toEntity()).toList();
        print(orderEntities);

        return Right(orderEntities);
      }

      return Left(Failure(error: response.statusMessage.toString(), statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }

  // Get a single order by ID
  Future<Either<Failure, OrderEntity>> getSingleOrder(String id) async {
    try {
      final token = await userSharedPrefs.getUserToken();
      token.fold((l) => throw Failure(error: l.error), (r) => r);

      final response = await dio.get(
        '${ApiEndpoints.getSingleOrder}/$id',
        options: Options(headers: {'authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final order = OrderModel.fromJson(response.data['data']);
        return Right(order.toEntity());
      }

      return Left(Failure(error: response.statusMessage.toString(), statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      return Left(Failure(error: e.message.toString()));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/failure/failure.dart';
import '../../data/model/order_model.dart';
import '../../domain/entity/OrderEntity.dart';
import '../../domain/repository/order_repository.dart';
import '../data_source/order_data_source.dart';


final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final orderRemoteDatasource = ref.read(orderRemoteDatasourceProvider);
  return OrderRepositoryImpl(orderRemoteDatasource: orderRemoteDatasource);
});

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDatasource orderRemoteDatasource;

  OrderRepositoryImpl({required this.orderRemoteDatasource});

  @override
  Future<Either<Failure, bool>> createOrder(OrderModel orderModel) async {
    return await orderRemoteDatasource.createOrder(orderModel);
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getUserOrders() async {
    final orders=await orderRemoteDatasource.getUserOrders();
    print("repo $orders");
    return orderRemoteDatasource.getUserOrders();
  }
}

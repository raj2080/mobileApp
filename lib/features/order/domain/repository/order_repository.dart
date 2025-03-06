import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../../data/model/order_model.dart';
import '../entity/OrderEntity.dart';
import '../entity/OrderItemEntity.dart';
import '../entity/ShippingInfoEntity.dart';


abstract class OrderRepository {
  Future<Either<Failure, bool>> createOrder(OrderModel orderModel);

  Future<Either<Failure, List<OrderEntity>>> getUserOrders();
}

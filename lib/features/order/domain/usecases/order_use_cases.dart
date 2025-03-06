import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/failure/failure.dart';
import '../../data/model/order_model.dart';
import '../../data/repository/order_repository_impl.dart';
import '../../domain/repository/order_repository.dart';
import '../entity/OrderEntity.dart';

// Use Case for Creating an Order
class CreateOrderUseCase {
  final OrderRepository repository;

  CreateOrderUseCase(this.repository);

  Future<Either<Failure, bool>> execute(OrderModel orderModel) async {
    return await repository.createOrder(orderModel);
  }
}

// Use Case for Getting User Orders
class GetUserOrdersUseCase {
  final OrderRepository repository;

  GetUserOrdersUseCase(this.repository);

  Future<Either<Failure, List<OrderEntity>>> execute() async {
    final order =repository.getUserOrders();
    print("usecase:$order");
    return await repository.getUserOrders();
  }
}

// Providers for Use Cases
final createOrderUseCaseProvider = Provider<CreateOrderUseCase>((ref) {
  final orderRepository = ref.read(orderRepositoryProvider);
  return CreateOrderUseCase(orderRepository);
});

final getUserOrdersUseCaseProvider = Provider<GetUserOrdersUseCase>((ref) {
  final orderRepository = ref.read(orderRepositoryProvider);
  return GetUserOrdersUseCase(orderRepository);
});

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../../../core/failure/failure.dart';
import '../../data/model/order_model.dart';

import '../../domain/usecases/order_use_cases.dart';
import '../state/OrderState.dart';



// ViewModel Class
class OrderViewModel extends StateNotifier<OrderState> {
  final CreateOrderUseCase createOrderUseCase;
  final GetUserOrdersUseCase getUserOrdersUseCase;

  OrderViewModel({
    required this.createOrderUseCase,
    required this.getUserOrdersUseCase,
  }) : super(OrderState());

  Future<void> fetchUserOrders() async {
    state = state.copyWith(isLoading: true);
    final result = await getUserOrdersUseCase.execute();
    print("result $result");
    result.fold(
            (failure) => state = state.copyWith(isLoading: false, error: failure.error),

        (orders)=> state = state.copyWith(isLoading: false, orders: orders)
    );


  }

  Future<void> createOrder(OrderModel orderModel) async {
    state = state.copyWith(isLoading: true);
    final result = await createOrderUseCase.execute(orderModel);
    result.fold((failure)=>state = state.copyWith(isLoading: false, error: failure.error),
    (orders){
      state = state.copyWith(orders:[...?state.orders] );
    });

  }
}

// Providers for State and ViewModel
final orderViewModelProvider = StateNotifierProvider<OrderViewModel, OrderState>((ref) {
  final createOrderUseCase = ref.read(createOrderUseCaseProvider);
  final getUserOrdersUseCase = ref.read(getUserOrdersUseCaseProvider);
  return OrderViewModel(
    createOrderUseCase: createOrderUseCase,
    getUserOrdersUseCase: getUserOrdersUseCase,
  );
});

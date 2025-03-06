import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/OrderEntity.dart';

class OrderState {
  final bool isLoading;
  final  List<OrderEntity>? orders;
  final String? error;

  OrderState({
    this.isLoading = false,
    this.orders,
    this.error,
  });


  OrderState copyWith({
    bool? isLoading,
   List<OrderEntity>? orders,
    String? error
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      orders: orders ?? this.orders,
      error: error ?? this.error
    );
  }
}
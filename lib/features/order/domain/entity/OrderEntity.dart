import 'package:equatable/equatable.dart';

import 'OrderItemEntity.dart';
import 'ShippingInfoEntity.dart';

class OrderEntity extends Equatable {
  final String? id;
  final ShippingInfoEntity shippingInfo;
  final List<OrderItemEntity> orderItems;
  final String user;
  final String paymentInfo;
  final int itemsPrice;
  final int taxPrice;
  final int shippingPrice;
  final int totalPrice;
  final String orderStatus;

  const OrderEntity({
    this.id,
    required this.shippingInfo,
    required this.orderItems,
    required this.user,
    required this.paymentInfo,
    required this.itemsPrice,
    required this.taxPrice,
    required this.shippingPrice,
    required this.totalPrice,
    required this.orderStatus,
  });

  @override
  List<Object?> get props => [
    id,
    shippingInfo,
    orderItems,
    user,
    paymentInfo,
    itemsPrice,
    taxPrice,
    shippingPrice,
    totalPrice,
    orderStatus,
  ];
}

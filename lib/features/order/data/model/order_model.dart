import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/OrderEntity.dart';
import 'OrderItemModel.dart';
import 'ShippingInfoModel.dart';

part 'order_model.g.dart';

final orderModelProvider = Provider((ref) => OrderModel.empty());

@JsonSerializable()
class OrderModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final ShippingInfoModel shippingInfo;
  final List<OrderItemModel> orderItems;
  final String user;
  final String paymentInfo;
  final int itemsPrice;
  final int taxPrice;
  final int shippingPrice;
  final int totalPrice;
  final String orderStatus;

  const OrderModel({
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

  const OrderModel.empty()
    : id = '',
      shippingInfo = const ShippingInfoModel.empty(),
      orderItems = const [],
      user = '',
      paymentInfo = '',
      itemsPrice = 0,
      taxPrice = 0,
      shippingPrice = 0,
      totalPrice = 0,
      orderStatus = '';

  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      shippingInfo: shippingInfo.toEntity(),
      orderItems: orderItems.map((item) => item.toEntity()).toList(),
      user: user,
      paymentInfo: paymentInfo,
      itemsPrice: itemsPrice,
      taxPrice: taxPrice,
      shippingPrice: shippingPrice,
      totalPrice: totalPrice,
      orderStatus: orderStatus,
    );
  }

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      id: entity.id,
      shippingInfo: ShippingInfoModel.fromJson(entity.shippingInfo as Map<String, dynamic>),
      orderItems: entity.orderItems.map((item) => OrderItemModel.fromJson(item as Map<String, dynamic>)).toList(),
      user: entity.user,
      paymentInfo: entity.paymentInfo,
      itemsPrice: entity.itemsPrice,
      taxPrice: entity.taxPrice,
      shippingPrice: entity.shippingPrice,
      totalPrice: entity.totalPrice,
      orderStatus: entity.orderStatus,
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

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

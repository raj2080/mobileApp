// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
  id: json['_id'] as String?,
  shippingInfo: ShippingInfoModel.fromJson(json['shippingInfo'] as Map<String, dynamic>),
  orderItems:
      (json['orderItems'] as List<dynamic>).map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>)).toList(),
  user: json['user'] as String,
  paymentInfo: json['paymentInfo'] as String,
  itemsPrice: json['itemsPrice'] as int,
  taxPrice: json['taxPrice'] as int,
  shippingPrice: json['shippingPrice'] as int,
  totalPrice: json['totalPrice'] as int,
  orderStatus: json['orderStatus'] as String,
);

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) => <String, dynamic>{
  '_id': instance.id,
  'shippingInfo': instance.shippingInfo.toJson(),
  'orderItems': instance.orderItems.map((e) => e.toJson()).toList(),
  'user': instance.user,
  'paymentInfo': instance.paymentInfo,
  'itemsPrice': instance.itemsPrice,
  'taxPrice': instance.taxPrice,
  'shippingPrice': instance.shippingPrice,
  'totalPrice': instance.totalPrice,
  'orderStatus': instance.orderStatus,
};

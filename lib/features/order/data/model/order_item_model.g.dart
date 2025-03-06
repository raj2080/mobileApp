// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    OrderItemModel(
      productName: json['productName'] as String,
      price: json['price'] as int,
      quantity: json['quantity'] as int,
      productImg: json['productImg'] as String,
      productId: json['_id'] as String,
    );

Map<String, dynamic> _$OrderItemModelToJson(OrderItemModel instance) =>
    <String, dynamic>{
      'productName': instance.productName,
      'price': instance.price,
      'quantity': instance.quantity,
      'productImg': instance.productImg,
      'productId': instance.productId,
    };

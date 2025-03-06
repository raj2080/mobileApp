import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/OrderItemEntity.dart';

part 'order_item_model.g.dart';

@JsonSerializable()
class OrderItemModel extends Equatable {
  final String productName;
  final int price;
  final int quantity;
  final String productImg;
  final String productId;

  const OrderItemModel({
    required this.productName,
    required this.price,
    required this.quantity,
    required this.productImg,
    required this.productId,
  });

  const OrderItemModel.empty()
      : productName = '',
        price = 0,
        quantity = 0,
        productImg = '',
        productId = '';

  OrderItemEntity toEntity() {
    return OrderItemEntity(
      productName: productName,
      price: price.toDouble(), // Convert int to double if needed
      quantity: quantity,
      productImg: productImg,
      productId: productId,
    );
  }
  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);

  @override
  List<Object?> get props => [productName, price, quantity, productImg, productId];
}

import 'package:equatable/equatable.dart';

class OrderItemEntity extends Equatable {
  final String productName;
  final double price;
  final int quantity;
  final String productImg;
  final String productId;

  const OrderItemEntity({
    required this.productName,
    required this.price,
    required this.quantity,
    required this.productImg,
    required this.productId,
  });

  @override
  List<Object?> get props => [
    productName,
    price,
    quantity,
    productImg,
    productId,
  ];
}

import 'package:equatable/equatable.dart';
 
class ProductEntity extends Equatable {
  final String? id;
  final String productName;
  final int productPrice;
  final String productCategory;
  final String productDescription;
  final String productImage;
  final String createdAt;
 
  const ProductEntity({
    this.id,
    required this.productName,
    required this.productPrice,
    required this.productCategory,
    required this.productDescription,
    required this.productImage,
     required this.createdAt,
  });
  
  @override
  List<Object?> get props => [id,productName,productPrice,productCategory,productDescription,productImage,createdAt];


}
 
 
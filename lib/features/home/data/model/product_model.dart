import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/product_entity.dart';

part 'product_model.g.dart';

final productModelProvider = Provider((ref) => const ProductModel.empty());

@JsonSerializable()
class ProductModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String productName;
  final int productPrice;
  final String productCategory;
  final String productDescription;
  final String? productImage;
  final String createdAt;

  const ProductModel({
    this.id,
    required this.productName,
    required this.productPrice,
    required this.productCategory,
    required this.productDescription,
    required this.productImage,
    required this.createdAt,
  });

  const ProductModel.empty()
    : id = '',
      productName = '',
      productCategory = '',
      productDescription = '',
      productImage = '',
      productPrice = 0,
      createdAt = '';

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      productName: productName,
      productPrice: productPrice,
      productCategory: productCategory,
      productDescription: productDescription,
      productImage: productImage!,
      createdAt: createdAt,
    );
  }

  ProductModel fromEntity(ProductEntity entity) {
    return ProductModel(
      id: id,
      productName: productName,
      productPrice: productPrice,
      productCategory: productCategory,
      productDescription: productDescription,
      productImage: productImage,
      createdAt: createdAt,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  List<ProductEntity> toEntityList(List<ProductModel> models) => models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
    id,
    productName,
    productPrice,
    productCategory,
    productDescription,
    productImage,
    createdAt,
  ];
}

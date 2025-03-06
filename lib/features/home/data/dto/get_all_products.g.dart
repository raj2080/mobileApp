// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllProductsDTO _$GetAllProductsDTOFromJson(Map<String, dynamic> json) =>
    GetAllProductsDTO(
      success: json['success'] as bool,
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllProductsDTOToJson(GetAllProductsDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'products': instance.products,
    };

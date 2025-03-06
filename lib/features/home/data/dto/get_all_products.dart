import 'package:json_annotation/json_annotation.dart';

import '../model/product_model.dart';

part 'get_all_products.g.dart';

@JsonSerializable()
class GetAllProductsDTO {
  final bool success;
  final List<ProductModel> products;

  GetAllProductsDTO({required this.success, required this.products});

  factory GetAllProductsDTO.fromJson(Map<String, dynamic> json) => _$GetAllProductsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllProductsDTOToJson(this);
}

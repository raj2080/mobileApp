import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/ShippingInfoEntity.dart';

part 'shipping_info_model.g.dart';

@JsonSerializable()
class ShippingInfoModel extends Equatable {
  final String address;
  final String city;
  final String province;
  final String country;
  final int postalCode;
  final int phoneNo;

  const ShippingInfoModel({
    required this.address,
    required this.city,
    required this.province,
    required this.country,
    required this.postalCode,
    required this.phoneNo,
  });

  const ShippingInfoModel.empty()
      : address = '',
        city = '',
        province = '',
        country = '',
        postalCode = 0,
        phoneNo = 0;

  ShippingInfoEntity toEntity() {
    return ShippingInfoEntity(
      address: address,
      city: city,
      province: province,
      country: country,
      postalCode: postalCode,
      phoneNo: phoneNo,
    );
  }

  factory ShippingInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ShippingInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingInfoModelToJson(this);

  @override
  List<Object?> get props => [address, city, province, country, postalCode, phoneNo];
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShippingInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


ShippingInfoModel _$ShippingInfoModelFromJson(Map<String, dynamic> json) =>
    ShippingInfoModel(
      address: json['address'] as String,
      city: json['city'] as String,
      province: json['province'] as String,
      country: json['country'] as String,
      postalCode: json['postalCode'] as int,
      phoneNo: json['phoneNo'] as int,
    );

Map<String, dynamic> _$ShippingInfoModelToJson(ShippingInfoModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'city': instance.city,
      'province': instance.province,
      'country': instance.country,
      'postalCode': instance.postalCode,
      'phoneNo': instance.phoneNo,
    };

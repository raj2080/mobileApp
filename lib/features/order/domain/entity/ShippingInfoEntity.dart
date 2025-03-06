import 'package:equatable/equatable.dart';

class ShippingInfoEntity extends Equatable {
  final String address;
  final String city;
  final String province;
  final String country;
  final int postalCode;
  final int phoneNo;

  const ShippingInfoEntity({
    required this.address,
    required this.city,
    required this.province,
    required this.country,
    required this.postalCode,
    required this.phoneNo,
  });

  @override
  List<Object?> get props => [
    address,
    city,
    province,
    country,
    postalCode,
    phoneNo,
  ];
}

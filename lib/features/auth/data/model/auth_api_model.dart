import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

final authApiModelProvider = Provider<AuthApiModel>((ref) => const AuthApiModel.empty());

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;

  const AuthApiModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
  });

  const AuthApiModel.empty() : id = '', firstName = '', lastName = '', email = '', password = '', phone = '';

  AuthEntity toEntity() {
    return AuthEntity(id: id, firstName: firstName, lastName: lastName, email: email, phone: phone, password: password);
  }

  AuthApiModel fromEntity(AuthEntity entity) {
    return AuthApiModel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,

      password: entity.password,
      phone: entity.phone,
    );
  }

  factory AuthApiModel.fromJson(Map<String, dynamic> json) => _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  @override
  List<Object?> get props => [id, firstName, lastName, password, phone];
}

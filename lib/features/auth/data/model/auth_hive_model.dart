//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:uuid/uuid.dart';
//
// part 'auth_hive_model.g.dart';
//
// final authHiveModelProvider = Provider((ref) => AuthHiveModel.empty());
//
// @HiveType(typeId: HiveTableConstant.userTableId)
// class AuthHiveModel {
//   @HiveField(0)
//   final String userId;
//   @HiveField(1)
//   final String firstName;
//   @HiveField(2)
//   final String lastName;
//   @HiveField(3)
//   final String phone;
//   @HiveField(4)
//   final String email;
//   @HiveField(5)
//   final String password;
//
//   // Constructor
//   AuthHiveModel({
//     String? userId,
//     required this.firstName,
//     required this.lastName,
//     required this.phone,
//     required this.email,
//     required this.password,
//   }) : userId = userId ?? const Uuid().v4();
//
//   // Empty constructor
//   AuthHiveModel.empty()
//       : this(
//           userId: '',
//           firstName: '',
//           lastName: '',
//           phone: '',
//           email: '',
//           password: '',
//         );
//
//   // Convert Entity to Hive Object
//   static AuthHiveModel fromEntity(AuthEntity entity) => AuthHiveModel(
//         userId: entity.id ?? const Uuid().v4(),
//         firstName: entity.firstName,
//         lastName: entity.lastName,
//         phone: entity.phone,
//         email: entity.email,
//         password: entity.password,
//       );
//
//   // Convert Hive Object to Entity
//   AuthEntity toEntity() => AuthEntity(
//         id: userId,
//         firstName: firstName,
//         lastName: lastName,
//         phone: phone,
//         email: email,
//         password: password,
//       );
//
//   @override
//   String toString() {
//     return 'userId: $userId, firstName: $firstName, lastName: $lastName, phone: $phone, email: $email, password: $password';
//   }
// }

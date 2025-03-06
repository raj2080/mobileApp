// import 'dart:io';
//
// import 'package:dartz/dartz.dart';
// import 'package:final_assignment/core/failure/failure.dart';
// import 'package:final_assignment/features/auth/data/data_source/local/auth_local_data_source.dart';
// import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../domain/repository/i_auth_repository.dart';
//
// final authLocalRepositoryProvider = Provider<IAuthRepository>((ref) {
//   return AuthLocalRepository(
//     ref.read(authLocalDataSourceProvider),
//   );
// });
//
// class AuthLocalRepository implements IAuthRepository {
//   final AuthLocalDataSource _authLocalDataSource;
//
//   AuthLocalRepository(this._authLocalDataSource);
//
//   @override
//   Future<Either<Failure, bool>> loginUser(String username, String password) {
//     return _authLocalDataSource.loginUser(username, password);
//   }
//
//   @override
//   Future<Either<Failure, bool>> registerUser(AuthEntity student) {
//     return _authLocalDataSource.registerUser(student);
//   }
//
//   @override
//   Future<Either<Failure, String>> uploadProfilePicture(File file) {
//     // TODO: implement uploadProfilePicture
//     throw UnimplementedError();
//   }
//   @override
//   Future<Either<Failure, bool>> changePassword(String oldPassword, String newPassword) {
//     // return authRemoteDataSource.changePassword(oldPassword: oldPassword, newPassword: newPassword);
//     throw UnimplementedError();
//   }
//
// }

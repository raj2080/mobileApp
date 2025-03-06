import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/internet_connectivity.dart';
import '../../../../core/failure/failure.dart';
import '../../data/repository/auth_remote_repository.dart';
import '../entity/auth_entity.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final checkConnectivity = ref.read(connectivityStatusProvider);
  if (checkConnectivity == ConnectivityStatus.isConnected) {
    return ref.read(authRemoteRepositoryProvider);
  } else {
    return ref.read(authRemoteRepositoryProvider);
  }
});

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerUser(AuthEntity student);
  Future<Either<Failure, bool>> loginUser(String username, String password);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
  Future<Either<Failure, bool>> changePassword(String oldPassword, String newPassword);
}

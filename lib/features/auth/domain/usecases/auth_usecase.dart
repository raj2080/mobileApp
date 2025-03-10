import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/auth_entity.dart';
import '../repository/i_auth_repository.dart';

final authUseCaseProvider = Provider((ref) {
  return AuthUseCase(ref.read(authRepositoryProvider));
});

class AuthUseCase {
  final IAuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    return await _authRepository.uploadProfilePicture(file);
  }

  Future<Either<Failure, bool>> registerUser(AuthEntity student) async {
    return await _authRepository.registerUser(student);
  }

  Future<Either<Failure, bool>> loginUser(String? username, String? password) async {
    return await _authRepository.loginUser(username ?? "", password ?? "");
  }

  Future<Either<Failure, bool>> changePassword(String oldPassword, String newPassword) async {
    return await _authRepository.changePassword(oldPassword, newPassword);
  }

  getCurrentUser() {}
}

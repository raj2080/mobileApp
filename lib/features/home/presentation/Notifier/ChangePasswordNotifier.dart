import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/domain/usecases/auth_usecase.dart';
import '../state/ChangePasswordState.dart';

class ChangePasswordNotifier extends StateNotifier<ChangePasswordState> {
  final AuthUseCase _authUseCase;

  ChangePasswordNotifier(this._authUseCase) : super(ChangePasswordState.initial());

  Future<void> changePassword(String oldPassword, String newPassword) async {
    state = state.copyWith(isLoading: true);

    final result = await _authUseCase.changePassword(oldPassword, newPassword);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, isSuccess: false, error: failure.error);
      },
      (isSuccess) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: isSuccess,
          error: isSuccess ? null : 'Failed to change password',
        );
      },
    );
  }
}

final changePasswordNotifierProvider = StateNotifierProvider<ChangePasswordNotifier, ChangePasswordState>((ref) {
  final authUseCase = ref.read(authUseCaseProvider);
  return ChangePasswordNotifier(authUseCase);
});

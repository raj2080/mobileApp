import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/repositories/auth_repository.dart';

part 'login_provider.freezed.dart';

// Login State
@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool isLoading,
    @Default(false) bool isPasswordVisible,
    @Default('') String errorMessage,
    @Default(false) bool isValid,
  }) = _LoginState;
}

// Auth Repository provider
final authRepositoryProvider = Provider((ref) => AuthRepository());

// Login Provider
final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LoginNotifier(authRepository);
});

class LoginNotifier extends StateNotifier<LoginState> {
  final AuthRepository _authRepository;

  LoginNotifier(this._authRepository) : super(const LoginState());

  void updateEmail(String email) {
    state = state.copyWith(
      email: email,
      errorMessage: '',
      isValid: _validateInputs(email, state.password),
    );
  }

  void updatePassword(String password) {
    state = state.copyWith(
      password: password,
      errorMessage: '',
      isValid: _validateInputs(state.email, password),
    );
  }

  void togglePasswordVisibility() {
    state = state.copyWith(
      isPasswordVisible: !state.isPasswordVisible,
    );
  }

  Future<bool> login() async {
    if (!state.isValid) return false;

    state = state.copyWith(
      isLoading: true,
      errorMessage: '',
    );

    try {
      final result = await _authRepository.login(
        state.email,
        state.password,
      );

      // TODO: Store token/user data in secure storage

      state = state.copyWith(
        isLoading: false,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  bool _validateInputs(String email, String password) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email) && password.length >= 6;
  }
}
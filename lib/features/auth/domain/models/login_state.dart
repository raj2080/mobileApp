class LoginState {
  final String email;
  final String password;
  final bool isLoading;
  final bool isPasswordVisible;
  final String errorMessage;
  final String emailError;
  final String passwordError;

  LoginState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.isPasswordVisible = false,
    this.errorMessage = '',
    this.emailError = '',
    this.passwordError = '',
  });

  bool get isValid => email.isNotEmpty && password.isNotEmpty && password.length >= 6;

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    bool? isPasswordVisible,
    String? errorMessage,
    String? emailError,
    String? passwordError,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      errorMessage: errorMessage ?? this.errorMessage,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
    );
  }
}
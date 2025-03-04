class SignupState {
  final String email;
  final String password;
  final String confirmPassword;
  final String username;
  final bool isLoading;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final String errorMessage;
  final String currentTimestamp = '2025-03-04 08:36:42';
  final String currentUser = '2025raj';

  SignupState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.username = '',
    this.isLoading = false,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.errorMessage = '',
  });

  bool get isValidUsername {
    if (username.isEmpty) return false;
    if (username.length < 1 || username.length > 10) return false;
    return RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username);
  }

  bool get isValidEmail {
    if (email.isEmpty) return false;
    return RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$').hasMatch(email);
  }

  bool get isValidPassword {
    return password.length >= 6;
  }

  bool get isValid =>
      isValidUsername &&
          isValidEmail &&
          isValidPassword &&
          password == confirmPassword;

  SignupState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? username,
    bool? isLoading,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    String? errorMessage,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      username: username ?? this.username,
      isLoading: isLoading ?? this.isLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
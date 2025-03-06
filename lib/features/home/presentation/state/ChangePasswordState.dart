
class ChangePasswordState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  ChangePasswordState({
    required this.isLoading,
    required this.isSuccess,
    this.error,
  });

  factory ChangePasswordState.initial() {
    return ChangePasswordState(
      isLoading: false,
      isSuccess: false,
      error: null,
    );
  }

  ChangePasswordState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return ChangePasswordState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }

  ChangePasswordState reset() {
    return ChangePasswordState.initial();
  }
}


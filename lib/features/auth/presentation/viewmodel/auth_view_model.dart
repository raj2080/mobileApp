import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/my_snackbar.dart';
import '../../domain/entity/auth_entity.dart';
import '../../domain/usecases/auth_usecase.dart';
import '../navigator/login_navigator.dart';
import '../state/auth_state.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(ref.read(loginViewNavigatorProvider), ref.read(authUseCaseProvider)),
);

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthUseCase authUseCase;
  final LoginViewNavigator navigator;

  AuthViewModel(this.navigator, this.authUseCase) : super(AuthState.initial());

  Future<void> uploadImage(File? file) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.uploadProfilePicture(file!);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        //showMySnackBar(message: failure.error, color: Colors.red);
      },
      (imageName) {
        state = state.copyWith(isLoading: false, error: null, imageName: imageName);
      },
    );
  }

  Future<void> registerUser(AuthEntity student) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.registerUser(student);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        //showMySnackBar(message: failure.error, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showMySnackBar(message: "Successfully registered");
        navigator.openHomeView(); // Navigate to home view after successful registration
      },
    );
  }

  Future<bool> loginUser(String username, String password) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.loginUser(username, password);
    return data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        // showMySnackBar(message: failure.error, color: Colors.red);
        return false;
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        navigator.openHomeView();
        return true;
      },
    );
  }
}

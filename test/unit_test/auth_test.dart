import 'package:blushstore/core/failure/failure.dart';
import 'package:blushstore/features/auth/domain/entity/auth_entity.dart';
import 'package:blushstore/features/auth/domain/usecases/auth_usecase.dart';
import 'package:blushstore/features/auth/presentation/navigator/login_navigator.dart';
import 'package:blushstore/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'auth_test.mocks.dart';

const correctUsername = 'blush';
const correctPassword = "blush123";

@GenerateNiceMocks([MockSpec<AuthUseCase>(), MockSpec<LoginViewNavigator>()])
Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthUseCase mockAuthUsecase;
  late ProviderContainer container;
  late LoginViewNavigator mockLoginViewNavigator;

  setUp(() {
    mockAuthUsecase = MockAuthUseCase() as AuthUseCase;
    mockLoginViewNavigator = MockLoginViewNavigator() as LoginViewNavigator;
    container = ProviderContainer(
      overrides: [authViewModelProvider.overrideWith((ref) => AuthViewModel(mockLoginViewNavigator, mockAuthUsecase))],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('check for the initial state in Auth State', () {
    final authstate = container.read(authViewModelProvider);
    expect(authstate.isLoading, false);
    expect(authstate.error, isNull);
    expect(authstate.imageName, isNull);
  });

  test('login test with valid username and password', () async {
    // Arrange
    when(mockAuthUsecase.loginUser(any, any)).thenAnswer((invocation) {
      final username = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(
        username == correctUsername && password == correctPassword
            ? const Right(true)
            : Left(Failure(error: 'Invalid Credentials')),
      );
    });

    // Act
    await container.read(authViewModelProvider.notifier).loginUser(correctUsername, correctPassword);
    final authState = container.read(authViewModelProvider);

    // Assert
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.imageName, isNull);
  });

  test('loading state is managed correctly during login process', () async {
    // Arrange
    when(mockAuthUsecase.loginUser(any, any)).thenAnswer((_) async {
      expect(container.read(authViewModelProvider).isLoading, true);
      return const Right(true);
    });

    // Act
    await container.read(authViewModelProvider.notifier).loginUser(correctUsername, correctPassword);

    // Assert
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    verify(mockAuthUsecase.loginUser(correctUsername, correctPassword)).called(1);
  });

  test('Registration failure updates error state', () async {
    final testUser = AuthEntity(
      firstName: "blush",
      lastName: "testing",
      email: "blush123@example.com",
      password: "Password123",
      phone: "1234567890",
    );

    // Arrange
    when(mockAuthUsecase.registerUser(testUser)).thenAnswer((_) async => Left(Failure(error: "Email already exists")));

    // Act
    await container.read(authViewModelProvider.notifier).registerUser(testUser);

    // Assert
    expect(container.read(authViewModelProvider).isLoading, isFalse);
    expect(container.read(authViewModelProvider).error, "Email already exists");
    verify(mockAuthUsecase.registerUser(testUser)).called(1);
  });
}

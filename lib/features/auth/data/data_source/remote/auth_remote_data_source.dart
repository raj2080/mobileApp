import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../app/constants/api_endpoint.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/networking/remote/http_service.dart';
import '../../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../../domain/entity/auth_entity.dart';
import '../../model/auth_api_model.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(
    dio: ref.watch(httpServiceProvider),
    authApiModel: ref.watch(authApiModelProvider),
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio dio;
  final AuthApiModel authApiModel;
  final UserSharedPrefs userSharedPrefs;

  AuthRemoteDataSource({required this.userSharedPrefs, required this.dio, required this.authApiModel});

  Future<Either<Failure, bool>> registerUser(AuthEntity authEntity) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.register,
        data: {
          "firstName": authEntity.firstName,
          "lastName": authEntity.lastName,
          "email": authEntity.email,
          "password": authEntity.password,
          "phone": int.tryParse(authEntity.phone) ?? 0,
        },
      );
      print(response);
      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');
      if (response.statusCode == 201) {
        return const Right(true);
      }
      return Left(Failure(error: response.data['message'], statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }

  Future<Either<Failure, AuthEntity>> getUser() async {
    try {
      final token = await userSharedPrefs.getUserToken();
      final userId = await userSharedPrefs.getUserId();

      final response = await dio.get(
        ApiEndpoints.getuser,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response);

      if (response.statusCode == 200) {
        final userData = response.data;
        final authApiModel = AuthApiModel.fromJson(userData);
        final authEntity = authApiModel.toEntity();
        return Right(authEntity);
      } else {
        return Left(Failure(error: response.data['message'], statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }

  Future<Either<Failure, bool>> loginUser({required String email, required String password}) async {
    try {
      print("$email and $password");
      Response response = await dio.post(ApiEndpoints.login, data: {'email': email, 'password': password});
      print(response);

      if (response.statusCode == 200) {
        final token = response.data['token'];
        final userData = response.data['userData'];
        final userId = userData['_id'];
        final email = userData['email'];
        final phone = userData['phone'];
        final firstname = userData['firstName'];
        final lastname = userData['lastName'];
        await userSharedPrefs.setUserToken(token);
        await userSharedPrefs.setEmail(email);
        await userSharedPrefs.setPhone(phone);
        await userSharedPrefs.setFirstName(firstname);
        await userSharedPrefs.setLastName(lastname);
        await userSharedPrefs.setUserId(userId);

        return const Right(true);
      }

      return Left(Failure(error: response.data['message'], statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }

  Future<Either<Failure, bool>> changePassword({required String oldPassword, required String newPassword}) async {
    try {
      final token = await userSharedPrefs.getUserToken();
      final authToken = token.fold((l) => throw Failure(error: l.error), (r) => r);
      print(authToken);
      final response = await dio.put(
        ApiEndpoints.changePassword,
        data: {'oldPassword': oldPassword, 'newPassword': newPassword},
        options: Options(headers: {'Authorization': 'Bearer $authToken'}),
      );
      print(response);
      if (response.statusCode == 200) {
        return const Right(true);
      }
      return Left(
        Failure(
          error: response.data['message'] ?? 'Password change failed',
          statusCode: response.statusCode.toString(),
        ),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }
}

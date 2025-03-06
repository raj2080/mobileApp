import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/constants/api_endpoint.dart';
import 'dio_error_interceptor.dart';

final httpServiceProvider = Provider<Dio>((ref) => HttpService(Dio()).dio);

class HttpService {
  final Dio _dio;

  Dio get dio => _dio;

  HttpService(this._dio) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..interceptors.add(DioErrorInterceptor())
      // ..interceptors.add(PrettyDio)
      ..options.headers = {'Accept': 'application/json', 'Content-Type': 'application/json'};
  }
}

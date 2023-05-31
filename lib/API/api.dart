import 'package:dio/dio.dart';
import 'package:indooku_flutter/config/apiConfig.dart';

final dio = Dio();

void init() {
  dio.options.baseUrl = ApiConfig.baseUrl;
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
    ),
  );

  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers['Accept'] = 'application/json';
}

class CustomException implements Exception {
  final String message;
  CustomException(this.message);
}

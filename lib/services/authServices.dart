import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:indooku_flutter/API/api.dart';
import 'package:indooku_flutter/config/apiConfig.dart';
import 'package:indooku_flutter/helper/secureStorageHelper.dart';
import 'package:indooku_flutter/models/user.dart';

class AuthService {
  static Future<User> login({
    required String email,
    required String password,
  }) async {
    const url = ApiConfig.login;
    final data = {
      'email': email,
      'password': password,
    };
    try {
      final response = await dio.post(
        url,
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = response.data;
        final status = responseJson['status'];
        if (status == false) {
          throw CustomException(
              response.data['message'].toString() ?? 'server error');
        }
        final token = responseJson['token'];
        final userJson = responseJson['data'];
        final user = User.fromJson(userJson);
        await SecureStorageHelper.cacheToken(token);
        await SecureStorageHelper.cacheUser(user);
        return user;
      } else {
        throw CustomException(
            response.data['message'].toString() ?? 'server error');
      }
    } on DioError catch (e) {
      throw CustomException(
          e.response?.data['message'].toString() ?? 'server error');
    }
  }

  static Future register({
    required String name,
    required String email,
    required String password,
  }) async {
    const url = ApiConfig.register;
    final data = {
      'name': name,
      'email': email,
      'password': password,
    };

    try {
      final response = await dio.post(
        url,
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = response.data;
        final status = responseJson['status'];
        if (status == false) {
          throw CustomException(
              response.data['message'].toString() ?? 'server error');
        }
        final token = responseJson['token'];
        final userJson = responseJson['data'];
        final user = User.fromJson(userJson);
        await SecureStorageHelper.cacheToken(token);
        await SecureStorageHelper.cacheUser(user);
        return user;
      }
    } on DioError catch (e) {
      throw CustomException(
          e.response?.data['message'].toString() ?? 'server error');
    }
  }

  static Future<bool> logout() async {
    const url = ApiConfig.logout;

    try {
      final getToken = await SecureStorageHelper.getToken();

      final response = await dio.post(
        url,
        options: Options(headers: {'Authorization': 'Bearer $getToken'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = response.data;
        final status = responseJson['status'];

        if (status == true) {
          return true;
        } else {
          return false;
        }
      }

      return false;
    } on DioError catch (_) {
      return false;
    }
  }
}

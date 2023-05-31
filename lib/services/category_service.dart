import 'package:dio/dio.dart';
import 'package:indooku_flutter/API/api.dart';
import 'package:indooku_flutter/config/apiConfig.dart';
import 'package:indooku_flutter/models/category.dart';

class CategoryService {
  static Future<List<Category>> getcategorys() async {
    const url = ApiConfig.category;
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = response.data;
        final status = responseJson['status'];
        if (status == false) {
          throw CustomException(
              response.data['message'].toString() ?? 'server error');
        }
        final List data = responseJson['data'];
        final List<Category> categories = [];
        for (var element in data) {
          categories.add(Category.fromJson(element));
        }
        return categories;
      } else {
        throw CustomException(
            response.data['message'] ?? 'Internal Server Error');
      }
    } on DioError catch (e) {
      throw CustomException(
          e.response?.data['message'] ?? 'Internal Server Error');
    }
  }
}

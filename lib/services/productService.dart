import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:indooku_flutter/API/api.dart';
import 'package:indooku_flutter/config/apiConfig.dart';
import 'package:indooku_flutter/models/product.dart';

class ProductService {
  static Future<List<Product>> getProducts({String? categoryId}) async {
    const url = ApiConfig.product;
    Map<String, dynamic>? query;
    if (categoryId != null) {
      query = {'category_id': categoryId};
    }

    try {
      final response = await dio.get(url, queryParameters: query);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseJson = response.data;
        final status = responseJson['status'];
        if (status == false) {
          throw CustomException(
              response.data['message'].toString() ?? 'server error');
        }
        final List data = responseJson['data'];

        final List<Product> products = [];
        for (var element in data) {
          products.add(Product.fromJson(element));
        }
        return products;
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

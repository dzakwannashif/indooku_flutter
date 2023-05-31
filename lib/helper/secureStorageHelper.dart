import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:indooku_flutter/models/user.dart';

class SecureStorageHelper {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  static const keyToken = 'token'; //! Membuat storage
  static Future cacheToken(String token) async {
    await _storage.write(key: keyToken, value: token);
  }

  static Future<String?> getToken() async {
    //! Mengambil dari storage
    final token = await _storage.read(key: keyToken);
    return token;
  }

  static const keyUser = 'user'; //! Membuat storage
  static Future cacheUser(User user) async {
    await _storage.write(key: keyUser, value: jsonEncode(user.toJson()));
  }

  static Future<User?> getUser() async {
    //! Mengambil dari storage
    final userString = await _storage.read(key: keyUser);
    if (userString != null) {
      final userJson = jsonDecode(userString);

      final userObject = User.fromJson(userJson);

      return userObject;
    } else {
      return null;
    }
  }

  static Future deleteDataLokalSemua() async {
    await _storage.deleteAll();
  }
}

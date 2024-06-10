import 'dart:convert';
import 'package:gemini/features/authentication/data/models/user_model.dart';
import 'package:gemini/features/authentication/domain/entities/user.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class UserLocalDatasource {
  cacheUserData(User userData);
  cacheToken(String token);
  Future<UserModel> getUserData();
  Future<String> getToken();
}

class UserLocalDatasourceImpl implements UserLocalDatasource {
   
  // Create storage
  final storage = const FlutterSecureStorage();

  final userCacheKey = "userKey";
  final tokenKey = "tokenKey";
  SharedPreferences? sharedPreferences;
  @override
  cacheUserData(User userData) async {

    final data = await storage.write(
       key: userCacheKey, value: jsonEncode(userData.toMap()));
    return data;
  }

  @override
  Future<UserModel> getUserData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final data = sharedPreferences.getString(userCacheKey)!;
    return UserModel.fromJson(json.decode(data));
  }

  @override
  cacheToken(String token) async {
    // Read value
    await storage.write(key: tokenKey, value: token);
  }

  @override
  Future<String> getToken() async {
    final token = await storage.read(key: tokenKey);
    return token!;
  }
}

import 'dart:convert';
import 'package:gemini/features/authentication/data/models/authorization_model.dart';
import 'package:gemini/features/authentication/data/models/user_model.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class UserLocalDatasource {
  cacheUserData(Map<String,dynamic> userData);
  cacheToken(AuthorizationModel authorization);
  Future<Map<String,dynamic>> getCachedUser();
  Future<AuthorizationModel> getToken();
}

class UserLocalDatasourceImpl implements UserLocalDatasource {
   
  // Create storage
  final storage = const FlutterSecureStorage();

  final userCacheKey = "userKey";
  final tokenKey = "tokenKey";
  SharedPreferences? sharedPreferences;
  @override
  cacheUserData(Map<String,dynamic> userData) async {

    final data = await storage.write(
       key: userCacheKey, value: jsonEncode(userData));
    return data;
  }

  @override
  Future<Map<String,dynamic>> getCachedUser() async {
    final data = await storage.read(key:userCacheKey);
    return json.decode(data!);
  }

  @override
  cacheToken(AuthorizationModel authorization) async {
    // Read value
    await storage.write(key: tokenKey, value:jsonEncode( authorization));
  }

  @override
  Future<AuthorizationModel> getToken() async {
    final authorization = await storage.read(key: tokenKey);
    return AuthorizationModel.fromJson(jsonDecode(authorization!));
  }
}

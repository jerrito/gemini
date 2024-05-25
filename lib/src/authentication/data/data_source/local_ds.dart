import 'dart:convert';
import 'package:gemini/src/authentication/data/models/user_model.dart';
import 'package:gemini/src/authentication/domain/entities/user.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class UserLocalDatasource {
  cacheUserData(User userData);
  cacheToken(String token);
  Future<UserModel> getUserData();
}

class UserLocalDatasourceImpl implements UserLocalDatasource {
  final userCacheKey = "userKey";
  final tokenKey = "tokenKey";
  SharedPreferences? sharedPreferences;
  @override
  cacheUserData(User userData) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    print(userData);
    final data = await sharedPreferences.setString(
        userCacheKey, jsonEncode(userData.toMap()));
    return data;
  }

  @override
  Future<UserModel> getUserData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final data = sharedPreferences.getString(userCacheKey)!;
    return UserModel.fromJson(json.decode(data));
  }
  
  @override
  cacheToken(String token) {
    // TODO: implement cacheToken
    throw UnimplementedError();
  }
}

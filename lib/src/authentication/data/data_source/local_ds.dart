import 'dart:convert';
import 'package:gemini/src/authentication/data/models/user_model.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UserLocalDatasource {
  cacheUserData(User user, String userName);
  Future<User> getUserData();
}

class UserLocalDatasourceImpl implements UserLocalDatasource {
  final userCacheKey = "userKey";
  @override
  cacheUserData(User user, String userName) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final Map<String,dynamic>  userData = {
      "userName":userName,
      "email":user.email,
      
    };
    print(user);
    print(userData);
    final data = await sharedPreferences.setString(
        userCacheKey, jsonEncode(userData));
    return data;
  }

  @override
  Future<User> getUserData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final data = sharedPreferences.getString(userCacheKey)!;
    return User.fromJson(json.decode(data))!;
  }
}

import 'dart:convert';
import 'package:gemini/src/authentication/data/models/user_model.dart';
import 'package:gemini/src/authentication/domain/entities/user.dart' as u;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UserLocalDatasource {
  cacheUserData(User user, u.User userData);
  Future<UserModel> getUserData();
}

class UserLocalDatasourceImpl implements UserLocalDatasource {
  final userCacheKey = "userKey";
  SharedPreferences? sharedPreferences;
  @override
  cacheUserData(User user, u.User userData) async {
    final sharedPreferences = await SharedPreferences.getInstance();
   
    print(user);
    print(userData);
    final data =
        await sharedPreferences.setString(userCacheKey,
         jsonEncode(userData.toMap()));
    return data;
  }

  @override
  Future<UserModel> getUserData() async {
   
    final sharedPreferences = await SharedPreferences.getInstance();
    final data = sharedPreferences.getString(userCacheKey)!;
    return UserModel.fromJson(json.decode(data));
  }
}

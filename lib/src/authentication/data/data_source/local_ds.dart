import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UserLocalDatasource {
  cacheUserData(User user);
 Future<User>  getUserData();
}

class UserLocalDatasourceImpl implements UserLocalDatasource {
  final userCacheKey = "userKey";
  @override
  cacheUserData(User user) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final data = await sharedPreferences.setString(
        userCacheKey,jsonEncode( user.toJson()));
    return data;
  }

  @override
  Future<User> getUserData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final data =  sharedPreferences.getString(userCacheKey)!;
    return  User.fromJson( json.decode(data))!;
  }
}

import 'dart:convert';

import 'package:gemini/core/urls/urls.dart';
import 'package:gemini/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserRemoteDatasource {
 //s
  Future<UserModel> signupUser(Map<String, dynamic> params);
  
  
  Future<UserModel> signinUser(Map<String, dynamic> params);
  
  
  Future<dynamic> verifyOTP(Map<String, dynamic> params);
  
  //confrm token
  Future<bool> confirmToken(Map<String, dynamic> params);
  
  //get OTP
  Future<dynamic> getOTP(Map<String, dynamic> params);
 
 //get user from token
  Future<dynamic> getUserFromToken(Map<String, dynamic> params);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final httpClient = http.Client;
  @override
  Future<UserModel> signupUser(Map<String, dynamic> params) async {
    Map<String, String>? headers = {};
    final response = await http.post(
        Uri.parse("https://jerrito_gemini$signupUrl"),
        headers: headers,
        body: {
          "name": params["name"],
          "email": params["email"],
          "password": params["password"],
        });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception();
    }
  }

  @override
  Future<UserModel> signinUser(Map<String, dynamic> params) {
    // TODO: implement signinUser
    throw UnimplementedError();
  }

  @override
  Future<dynamic> verifyOTP(Map<String, dynamic> params) {
    // TODO: implement verifyOTP
    throw UnimplementedError();
  }

  @override
  Future<bool> confirmToken(Map<String, dynamic> params) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String? token = sharedPref.getString("tokenId");
    if (token == null) {
      sharedPref.setString("tokenId", "");
    }
    var tokenResponse = await http
        .post(Uri.parse("jerrto-gem/verify_token"), headers: <String, String>{
      "Content-Type": "application/json; charset=UTF-8",
      "tokenId": token!,
    });

    var response = jsonDecode(tokenResponse.body);
    print(response);
    return response;
  }
  
  @override
  Future getOTP(Map<String, dynamic> params) {
    // TODO: implement getOTP
    throw UnimplementedError();
  }
  
  @override
  Future getUserFromToken(Map<String, dynamic> params) async{
    // TODO: implement getUserFromToken
    throw UnimplementedError();
  }
}

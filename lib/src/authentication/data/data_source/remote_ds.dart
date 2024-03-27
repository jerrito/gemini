import 'dart:convert';

import 'package:gemini/core/urls/urls.dart';
import 'package:gemini/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDatasource {
  Future<UserModel> signupUser(Map<String, dynamic> params);
  Future<UserModel> signinUser(Map<String, dynamic> params);
  Future<dynamic> verifyOTP(Map<String, dynamic> params);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final httpClient = http.Client;
  @override
  Future<UserModel> signupUser(Map<String, dynamic> params) async {
    
     Map<String,String>? headers={};
    final response =
        await http.post(Uri.parse("https://jerrito_gemini$signupUrl"),
      headers:headers,
       body: {
        "name":params["name"],
        "email":params["email"],
        "password":params["password"],
       }
        );
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
}

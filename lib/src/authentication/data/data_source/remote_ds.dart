import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gemini/core/urls/urls.dart';
import 'package:gemini/src/authentication/data/models/user_model.dart';
import 'package:gemini/src/authentication/presentation/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
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
  Future<UserModel> getUserFromToken(
      Map<String, dynamic> params);

  //get ip address
  String getIPAddress();
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final http.Client client;

  UserRemoteDatasourceImpl({required this.client});
  @override
  Future<UserModel> signupUser(Map<String, dynamic> params) async {
    Map<String, String>? headers = {};
    headers.addAll(<String, String>{
      "Content-Type": "application/json; charset=UTF-8",
    });
    final response = await client.post(
        Uri.parse(getUrl(endpoint: Url.signupUrl.endpoint)),
        headers: headers,
        body: {
          "name": params["name"],
          "email": params["email"],
          "password": params["password"],
        });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
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
    var tokenResponse = await http.post(
        Uri.parse(getUrl(endpoint: Url.verifyTokenUrl.endpoint)),
        headers: <String, String>{
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
  Future<UserModel> getUserFromToken(
      Map<String, dynamic> params) async {
    Map<String, String>? headers = {};
    headers.addAll(<String, String>{
      "Content-Type": "application/json; charset=UTF-8",
    });
    final response = await http.get(
        Uri.parse(getUrl(endpoint: Url.homeUrl.endpoint)),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "tokenId": "",
        });

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
     
    } else {
      throw Exception([response.reasonPhrase]);
    }
  }

  @override
  String getIPAddress()  {
    final ipAddress =  InternetAddress.anyIPv4.address;
    return ipAddress;
  }
}

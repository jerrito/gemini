import 'dart:convert';

import 'package:gemini/core/error/error_handler.dart';
import 'package:gemini/core/urls/urls.dart';
import 'package:gemini/features/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserRemoteDatasource {
  //s
  Future<UserModel> signupUser(Map<String, dynamic> params);

  Future<DataModel> signinUser(Map<String, dynamic> params);

  //confrm token
  Future<bool> confirmToken(Map<String, dynamic> params);

  //get user from token
  Future<UserModel> getUserFromToken(Map<String, dynamic> params);

  // get user
  Future<UserModel> getUser(Map<String, dynamic> params);

  Future<String> logout(Map<String, dynamic> params);
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
    final Map<String, dynamic> body= {
          "userName": params["userName"],
          "email": params["email"],
          "password": params["password"],
          "profile": ""
        };
    final response = await client.post(
        getUri(
          endpoint: Url.signupUrl.endpoint,
        ),
        headers: headers,
        body:jsonEncode(body,),);
    final data = jsonDecode(response.body);
    print(data);
    if (response.statusCode == 200) {
      return UserModel.fromJson(data);
    } else {
      throw CustomException(
        error: data["error"],
        message: data["message"],
        errorCode: data["errorCode"],
      );
    }
  }

  @override
  Future<DataModel> signinUser(Map<String, dynamic> params) async {
     Map<String, String>? headers = {};
    headers.addAll(<String, String>{
      "Content-Type": "application/json; charset=UTF-8",
    });
    final Map<String, dynamic> body= {
          "email": params["email"],
          "password": params["password"],
        };
    final response = await client.post(
      getUri(endpoint: Url.signinUrl.endpoint),
        headers: headers,
        body:jsonEncode(body,),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return DataModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  @override
  Future<bool> confirmToken(Map<String, dynamic> params) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    String? token = sharedPref.getString("tokenId");
    if (token == null) {
      sharedPref.setString("tokenId", "");
    }
    var tokenResponse = await http.post(
        getUri(endpoint: Url.verifyTokenUrl.endpoint),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "tokenId": token!,
        });

    var response = jsonDecode(tokenResponse.body);
    print(response);
    return response;
  }

  @override
  Future<UserModel> getUserFromToken(Map<String, dynamic> params) async {
    Map<String, String>? headers = {};
    headers.addAll(<String, String>{
      "Content-Type": "application/json; charset=UTF-8",
    });
    final response = await http
        .get(getUri(endpoint: Url.homeUrl.endpoint), headers: <String, String>{
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
  Future<UserModel> getUser(Map<String, dynamic> params) async {
    Map<String, String>? headers = {};

    headers.addAll({
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": params["token"]
    });

    final response = await client.get(getUri(endpoint: Url.homeUrl.endpoint),
        headers: headers);
    return UserModel.fromJson(jsonDecode(response.body));
  }
  
  @override
  Future<String> logout(Map<String, dynamic> params) async{
  Map<String, String>? headers = {};

    headers.addAll({
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": params["token"]
    });

    final response = await client.post(getUri(endpoint: Url.homeUrl.endpoint),
        headers: headers);
    return jsonDecode(response.body);
  }
}

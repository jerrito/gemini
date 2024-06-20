import 'dart:convert';

import 'package:gemini/core/error/error_handler.dart';
import 'package:gemini/core/urls/urls.dart';
import 'package:gemini/features/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;
abstract class UserRemoteDatasource {
  //s
  Future<SignupResponseModel> signupUser(Map<String, dynamic> params);

  Future<SigninResponseModel> signinUser(Map<String, dynamic> params);


  //get user from token
  Future<UserModel> getUserFromToken(Map<String, dynamic> params);

  // get user
  Future<UserModel> getUser(Map<String, dynamic> params);

  Future<String> logout(Map<String, dynamic> params);

  Future<String> refreshToken(String refreshToken);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final http.Client client;

  UserRemoteDatasourceImpl({required this.client});
  @override
  Future<SignupResponseModel> signupUser(Map<String, dynamic> params) async {
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
    if (response.statusCode == 200) {
      return SignupResponseModel.fromJson(data);
    } else {
      throw CustomException(
        error: data["error"],
        message: data["message"],
        errorCode: data["errorCode"],
      );
    }
  }

  @override
  Future<SigninResponseModel> signinUser(Map<String, dynamic> params) async {
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
    if (response.statusCode == 200) {
      return SigninResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
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
        if(response.statusCode==200){
    return UserModel.fromJson(jsonDecode(response.body));
  }
    else{
      throw Exception("");
    }
  }
  
  @override
  Future<String> logout(Map<String, dynamic> params) async{
  Map<String, String>? headers = {};

    headers.addAll({
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": params["token"]
    });

    final response = await client.post(getUri(endpoint: Url.logoutUrl.endpoint,),
        headers: headers,);
    return response.body;
  }
  
  @override
  Future<String> refreshToken(String refreshToken) async{
    
    Map<String, String>? headers = {};

    headers.addAll({
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization":refreshToken
    });

    final response = await client.post(getUri(endpoint: Url.refreshUrl.endpoint),
        headers: headers);
    return (response.body);
  }
}

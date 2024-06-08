import 'dart:convert';

import 'package:gemini/core/urls/urls.dart';
import 'package:gemini/src/authentication/data/models/user_model.dart';
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
    final response = await client.post(getUrl(endpoint: Url.signupUrl.endpoint),
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
  Future<DataModel> signinUser(Map<String, dynamic> params) async {
    final response = await client.get(
      getUrl(endpoint: Url.signinUrl.endpoint),
    );

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
        getUrl(endpoint: Url.verifyTokenUrl.endpoint),
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
  Future<UserModel> getUserFromToken(Map<String, dynamic> params) async {
    Map<String, String>? headers = {};
    headers.addAll(<String, String>{
      "Content-Type": "application/json; charset=UTF-8",
    });
    final response = await http
        .get(getUrl(endpoint: Url.homeUrl.endpoint), headers: <String, String>{
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

    final response = await client.get(getUrl(endpoint: Url.homeUrl.endpoint),
        headers: headers);
    return jsonDecode(response.body);
  }
}

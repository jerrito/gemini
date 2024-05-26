import 'dart:convert';
import 'dart:io';

import 'package:gemini/core/urls/urls.dart';
import 'package:gemini/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

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
  Future<UserModel> getUserFromToken(Map<String, dynamic> params);

  //get ip address
  String getIPAddress();

  //signup supabase
  Future<UserModel> createUserWithEmailAndPassword(Map<String, dynamic> params);

  //signin otp
  Future<UserModel> signinWithEmailPassword(Map<String, dynamic> params);

  // signin with password
  Future<void> signInWithEmailLink(Map<String, dynamic> params);

  // get user
  Future<UserModel> getUser(Map<String, dynamic> params);
  //add userSupabase
  Future<bool> isSignInWithEmailLink(Map<String, dynamic> params);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final http.Client client;
  final firebaseAuth = FirebaseAuth.instance;
  //final firebase=Firebase.app();

  UserRemoteDatasourceImpl({required this.client});
  @override
  Future<UserModel> signupUser(Map<String, dynamic> params) async {
    Map<String, String>? headers = {};
    headers.addAll(<String, String>{
      "Content-Type": "application/json; charset=UTF-8",
    });
    final response = await client.post(
        getUrl(endpoint: Url.signupUrl.endpoint),
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
    final response = await http.get(
        getUrl(endpoint: Url.homeUrl.endpoint),
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
  String getIPAddress() {
    final ipAddress = InternetAddress.anyIPv4.address;
    return ipAddress;
  }

  @override
  Future<UserModel> createUserWithEmailAndPassword(
      Map<String, dynamic> params) async {
    final response = await client.post(getUrl(endpoint: Url.signupUrl.endpoint),
        body: params);
    return jsonDecode(response.body);
  }

  @override
  Future<UserModel> signinWithEmailPassword(Map<String, dynamic> params) async {
    final response = await client.get(
      getUrl(endpoint: Url.signinUrl.endpoint),
    );
    return jsonDecode(response.body);
  }

  @override
  Future<UserCredential> signInWithEmailLink(
      Map<String, dynamic> params) async {
    return await firebaseAuth.signInWithEmailLink(
        email: params["email"], emailLink: '');
  }

  @override
  Future<bool> isSignInWithEmailLink(Map<String, dynamic> params) async {
    return firebaseAuth.isSignInWithEmailLink(params["emailLink"]);
  }
  
  @override
  Future<UserModel> getUser(Map<String, dynamic> params)async {
   
   final response = await client.get(
      getUrl(endpoint: Url.homeUrl.endpoint),
    );
    return jsonDecode(response.body);
  }
}

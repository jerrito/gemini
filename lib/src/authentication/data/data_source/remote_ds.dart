import 'dart:convert';
import 'dart:io';
import 'package:gemini/core/urls/urls.dart';
import 'package:gemini/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  Future<AuthResponse> signUpSupabase(Map<String, dynamic> params);

  //signin otp
  Future<void> signInOTPSupabase(Map<String, dynamic> params);

  // signin with password
  Future<AuthResponse> signInPasswordSupabase(Map<String, dynamic> params);

  //add userSupabase
  Future<dynamic> addUserSupabase(Map<String, dynamic> params);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final http.Client client;
  final supabase = Supabase.instance.client;

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
  Future<UserModel> getUserFromToken(Map<String, dynamic> params) async {
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
  String getIPAddress() {
    final ipAddress = InternetAddress.anyIPv4.address;
    return ipAddress;
  }

  @override
  Future<AuthResponse> signUpSupabase(Map<String, dynamic> params) async {
    return await supabase.auth.signUp(
        email: params["email"],
        channel: OtpChannel.whatsapp,
        //emailRedirectTo: ,
        // data: {"userName": params["userName"]},
        phone: params["phone_number"],
        password: params["password"]);
  }

  @override
  Future<void> signInOTPSupabase(Map<String, dynamic> params) async {
    return await supabase.auth.signInWithOtp(
      email: params["email"],
      channel: OtpChannel.whatsapp,
      //emailRedirectTo: ,
      //data: {"userName": params["userName"]},
      phone: params["phone_number"],
    );
  }

  @override
  Future<AuthResponse> signInPasswordSupabase(
      Map<String, dynamic> params) async {
    return await supabase.auth.signInWithPassword(
      email: params["email"],

      //emailRedirectTo: ,
      password: params["password"],
      phone: params["phone_number"],
    );
  }

  @override
  Future addUserSupabase(Map<String, dynamic> params) async {
    return await supabase.from("GeminiAccount").insert({
      "userName": params["userName"],
      "email": params["email"],
    });
  }
}

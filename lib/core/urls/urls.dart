import 'dart:io';

enum Url {
  signupUrl(endpoint: "signup"),
  signinUrl(endpoint: "signin"),
  verifyOTPUrl(endpoint: "verify_otp"),
  verifyTokenUrl(endpoint: "verify_token"),
  homeUrl(endpoint: "me"),
  fUrl(endpoint: "verify_otp");

  final String endpoint;

  const Url({required this.endpoint});
}

Uri getUrl({required String endpoint}) {
  //192.168.9.140  154.160.9.66 154.160.23.34 192.168.187.239
  final ipAddress = InternetAddress.anyIPv4.address;

  //return ipAddress;
  print(ipAddress);

  String baseUrl = "://192.168.69.128:4000/jerrito_gemini/";
  return Uri.parse(
    baseUrl + endpoint);
}


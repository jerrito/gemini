import 'dart:io';

enum Url {
  signupUrl(endpoint: "api/auth/signup"),
  signinUrl(endpoint: "api/auth/signin"),
  verifyOTPUrl(endpoint: "api/verify_otp"),
  verifyTokenUrl(endpoint: "verify_token"),
  homeUrl(endpoint: "api/auth/me"),
  logoutUrl(endpoint: "api/auth/logout"),
  refreshUrl(endpoint: "api/auth/refresh"),
  fUrl(endpoint: "verify_otp");

  final String endpoint;

  const Url({required this.endpoint});
}

Uri getUri({required String endpoint}) {
  String baseUrl = "https://gemini-server-qpjy.onrender.com/";
  return Uri.parse(baseUrl + endpoint);
}

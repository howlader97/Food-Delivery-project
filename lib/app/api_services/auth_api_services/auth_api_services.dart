import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthApiServices {
  static Future<dynamic> signUpRequest(
    String url,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw ("Sign Up Request Failed $e");
    }
  }

  //signup otp verification
  static Future<dynamic> signUpOtpRequest(
    String url,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw ("Otp Request Failed $e");
    }
  }

  static Future<dynamic> signInRequest(
    String url,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: body,
      );
      return response;
    } catch (e) {
      throw ("Sign In Request Failed $e");
    }
  }

  static Future<dynamic> emailVerifyRequest(
    String url,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw ("Email Verification Request Failed $e");
    }
  }

  static Future<dynamic> resetPasswordRequest(
    String url,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw ("Email Verification Request Failed $e");
    }
  }

  static Future<String> googleSignInRequest(
    String url,
    String accessToken,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$url?access_token=$accessToken'),
        headers: {"Content-Type": "application/json"},
      );
      final data = jsonDecode(response.body); // decode JSON
      final token = data['access_token']; // extract token
      return token;
    } catch (e) {
      throw ("Google Authentication Request Failed $e");
    }
  }
}

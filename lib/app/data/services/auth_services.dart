import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final url = "http://localhost:5000";

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$url/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'username': username, 'password': password}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'access_token': data['access_token'],
          'username': data['username'],
          'email': data['email'],
        };
      } else {
        final data = jsonDecode(response.body);
        return {"success": false, 'message': data['msg']};
      }
    } catch (e) {
      return {"success": false, 'message': 'error : $e'};
    }
  }

  Future<Map<String, dynamic>> register(
    String username,
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$url/register"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {'success': true, 'message': data['msg']};
      } else {
        final data = jsonDecode(response.body);
        return {'success': false, 'message': data['msg']};
      }
    } catch (e) {
      return {'success': false, 'message': 'error : $e'};
    }
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse("$url/forgot-password"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'success': true, 'message': data['msg']};
      } else {
        final data = jsonDecode(response.body);
        return {'success': false, 'message': data['msg']};
      }
    } catch (e) {
      return {'success': false, 'message': 'error $e'};
    }
  }

  Future<Map<String, dynamic>> resetPassword(
    String email,
    String otp,
    String newPassword,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$url/reset-password"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'otp': otp,
          'new_password': newPassword,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'success': true, 'message': data['msg']};
      } else {
        final data = jsonDecode(response.body);
        return {'success': false, 'message': data['msg']};
      }
    } catch (e) {
      return {'success': false, 'message': "error : $e"};
    }
  }

  Future<Map<String, dynamic>> verifyOtp(String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse("$url/verify-otp"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'otp': otp}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'success': true, 'message': data['msg']};
      } else {
        final data = jsonDecode(response.body);
        return {'success': false, 'message': data['msg']};
      }
    } catch (e) {
      return {'success': false, 'message': 'error : $e'};
    }
  }

  Future<Map<String, dynamic>> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return {'success': false, 'message': 'Google sign-in cancelled'};
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final response = await http.post(
        Uri.parse('$url/google-signin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id_token': googleAuth.idToken,
          'access_token': googleAuth.accessToken,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'access_token': data['access_token'],
          'username': data['username'],
        };
      } else {
        final data = jsonDecode(response.body);
        return {'success': false, 'message': data['msg']};
      }
    } catch (e) {
      return {'success': false, 'message': 'error : $e'};
    }
  }
}

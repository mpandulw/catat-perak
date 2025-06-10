import 'dart:convert';

import 'package:http/http.dart' as http;

class AccountServices {
  final url = "http://localhost:5000";

  Future<Map<String, dynamic>> addAccount(
    String name,
    int balance,
    String token,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$url/account"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'name': name, 'balance': balance}),
      );
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {'success': true, 'message': data['msg']};
      } else {
        final data = jsonDecode(response.body);
        return {"success": false, 'message': data['msg']};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error : $e'};
    }
  }

  Future<Map<String, dynamic>> delAccount(String id, String token) async {
    try {
      final response = await http.delete(
        Uri.parse("$url/account/$id"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'success': true, 'message': data['msg']};
      } else {
        final data = jsonDecode(response.body);
        return {"success": false, 'message': data['msg']};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error : $e'};
    }
  }

  Future<List<Map<String, dynamic>>> getAccount(String token) async {
    try {
      final response = await http.get(
        Uri.parse("$url/account"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(jsonDecode(response.body));
      } else {
        throw Exception('Failed to fetch accounts');
      }
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  Future<Map<String, dynamic>> updateAccount(
    String id,
    String token,
    String name,
    int balance,
  ) async {
    try {
      final response = await http.put(
        Uri.parse("$url/account/$id"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'name': name, 'balance': balance}),
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
}

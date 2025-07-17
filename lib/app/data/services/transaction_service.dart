import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/app/data/models/item_transaksi_model.dart';

class TransactionService {
  final url = "https://catatperak.my.id/";

  Future<Map<String, dynamic>> addTransaction({
    required String token,
    required String type,
    required String name,
    required List<TransactionItem> items,
    required String account,
    required String note,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$url/transaction"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'type': type,
          'name': name,
          'items': items.map((e) => e.toJson()).toList(),
          'account': account,
          'note': note,
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
      return {'success': false, 'message': 'error: $e'};
    }
  }

  Future<List<Map<String, dynamic>>> getTransaction(String token) async {
    try {
      final response = await http.get(
        Uri.parse("$url/transaction"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        return List<Map<String, dynamic>>.from(jsonDecode(response.body));
      } else {
        throw Exception("Failed to fetch accounts");
      }
    } catch (e) {
      throw Exception('Error : $e');
    }
  }

  Future<Map<String, dynamic>> delTransaction(String token, String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$url/transaction/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'success': true, 'message': data['msg']};
      } else {
        final data = jsonDecode(response.body);
        return {'success': false, 'message': data['msg']};
      }
    } catch (e) {
      return {'succes': false, 'message': 'Error : $e'};
    }
  }

  Future<Map<String, dynamic>> getSummary(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$url/summary'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);

      return {
        'success': true,
        'income': data['total_income'],
        'expense': data['total_expense'],
      };
    } catch (e) {
      return {'success': false, 'message': 'Error : $e'};
    }
  }

  Future<Map<String, dynamic>> scanTransaction(File image, String token) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse('$url/upload'));
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        //   'Content-Type': 'application/json',
      });
      final response = await request.send();
      final responseData = await http.Response.fromStream(response);
      if (responseData.statusCode == 200) {
        final json = jsonDecode(responseData.body);
        return {'success': true, 'data': json};
      } else {
        final json = jsonDecode(responseData.body);
        return {'success': false, 'message': json['error']};
      }
    } catch (e) {
      return {'success': false, 'message': 'error : $e'};
    }
  }
}

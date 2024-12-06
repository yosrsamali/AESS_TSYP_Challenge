import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;

  String? get token => _token;

  Future<void> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:5000/api/auth/signin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _token = data['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      notifyListeners();
    } else {
      throw Exception('Authentication failed');
    }
  }

  Future<void> signUp(String email, String password) async {
    await http.post(
      Uri.parse('http://localhost:5000/api/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
  }

  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse(
          'http://localhost:5000/api/auth/api/change-password'), // Adjust URL
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      // Handle successful password change, if needed
      notifyListeners();
    } else {
      throw Exception('Failed to change password');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _token = null;
    notifyListeners();
  }
}

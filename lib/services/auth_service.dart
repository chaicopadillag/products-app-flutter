import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  // TODO: Add your Firebase project's API key
  final String _firebaseToken = 'xxx-token-app-firebase-aqui';

  final storage = const FlutterSecureStorage();

  // singup in Firebase
  Future<String?> signUp(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      'key': _firebaseToken,
    });
    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeRes = json.decode(response.body);
    // print(decodeRes);
    if (decodeRes.containsKey('idToken')) {
      storage.write(key: 'token', value: decodeRes['idToken']);
      return null;
    } else {
      return decodeRes['error']['message'];
    }
  }

  // sign in Firebase
  Future<String?> signIn(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
      'key': _firebaseToken,
    });
    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeRes = json.decode(response.body);
    // print(decodeRes);
    if (decodeRes.containsKey('idToken')) {
      storage.write(key: 'token', value: decodeRes['idToken']);
      return null;
    } else {
      return decodeRes['error']['message'];
    }
  }

// logout
  Future<void> logout() async {
    await storage.delete(key: 'token');
    notifyListeners();
  }

  // verify token from Firebase
  Future<String> isAuthenticated() async {
    return await storage.read(key: 'token') ?? '';
  }
}

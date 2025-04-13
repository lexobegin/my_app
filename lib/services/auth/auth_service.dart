import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_app/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/services/services.dart';

import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  bool _isLoggerdIn = false;
  User? _user;
  String? _token;

  bool get authentificated => _isLoggerdIn;
  User get user => _user!;
  Servidor servidor = Servidor();

  final _storage = const FlutterSecureStorage();

  Future<String> login(String email, String password) async {
    try {
      final response =
          await http.post(Uri.parse('${servidor.baseUrl}/auth/jwt/create/'),
              body: ({
                'email': email,
                'password': password,
              }));

      //print(response.statusCode);
      //print(response.body);
      if (response.statusCode == 200) {
        //String token = response.body.toString();
        // Parsear el cuerpo de la respuesta (JSON)
        Map<String, dynamic> responseJson = jsonDecode(response.body);

        // Extraer los tokens
        String accessToken = responseJson['access'];
        //String refreshToken = responseJson['refresh'];

        // Imprimir los tokens para depuración
        //print('Access Token: $accessToken');
        //print('Refresh Token: $refreshToken');
        //tryToken(token);
        tryToken(accessToken);
        return 'correcto';
      } else {
        return 'incorrecto';
      }
    } catch (e) {
      return 'error';
    }
  }

  Future<String> register(
      String firstname, String lastname, String email, String password) async {
    try {
      final response =
          await http.post(Uri.parse('${servidor.baseUrl}/auth/users/'),
              body: ({
                'first_name': firstname,
                'last_name': lastname,
                'email': email,
                'password': password,
                're_password': password,
              }));

      if (response.statusCode == 201) {
        //String token = response.body.toString();
        //tryToken(token);
        login(email, password);
        return 'correcto';
      } else {
        return 'incorrecto';
      }
    } catch (e) {
      return 'error';
    }
  }

  void tryToken(String? token) async {
    if (token == null) {
      return;
    } else {
      try {
        /*final response = await http.get(
            Uri.parse('${servidor.baseUrl}/auth/users/me/'),
            headers: {'Authorization': 'Bearer $token'});

        print('response body: ${response.body}');*/
        _isLoggerdIn = true;
        //_user = User.fromJson(jsonDecode(response.body));
        _token = token;
        storeToken(token);
        notifyListeners();
      } catch (e) {
        print(e);
      }
    }
  }

  void storeToken(String token) async {
    _storage.write(key: 'token', value: token);
  }

  void logout() async {
    try {
      /*final response = await http.get(
          Uri.parse('${servidor.baseUrl}/user/revoke'),
          headers: {'Authorization': 'Bearer $_token'});*/
      cleanUp();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void cleanUp() async {
    //_user = null;
    _isLoggerdIn = false;
    //_user = null;
    await _storage.delete(key: 'token');
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../provider/http_exception.dart';

class Auth {
  final String _token;
  final DateTime _expiryDate;
  final String _userId;

  Auth(
    this._token,
    this._expiryDate,
    this._userId,
  );
}

class AuthProvider with ChangeNotifier {
  Future<void> authentication(
    String email,
    String password,
    String urlSegment,
  ) async {
    final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDFnoW0Kztd1H1Fv79CJW1L6HhW1wmp1d8',
    );

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      final responseData = json.decode(response.body);
      print(responseData['error']['message']);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp(
    String email,
    String password,
  ) async {
    return authentication(
      email,
      password,
      'signUp',
    );
  }

  Future<void> logIn(
    String email,
    String password,
  ) async {
    return authentication(
      email,
      password,
      'signInWithPassword',
    );
  }
}
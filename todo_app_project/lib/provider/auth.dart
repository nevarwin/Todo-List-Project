import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../provider/http_exception.dart';

class Auth {}

class AuthProvider with ChangeNotifier {
  // TODO: Review

  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  bool get isAuth {
    return _token != null;
  }

  String? get getToken {
    if (_token != null && _expiryDate != null && _expiryDate!.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

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

      if (responseData['error'] != null) {
        throw HttpException(
          responseData['error']['message'],
        );
      }

      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
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

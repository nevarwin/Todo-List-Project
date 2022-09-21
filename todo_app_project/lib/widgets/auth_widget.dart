import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_project/provider/http_exception.dart';

import '../provider/auth.dart';

enum AuthMode {
  signup,
  login,
}

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final _formKey = GlobalKey<FormState>();
  final _passCtrl = TextEditingController();
  AuthMode _authMode = AuthMode.login;

  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void errorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('An error occured!'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Okay'),
            )
          ],
        );
      },
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    try {
      if (_authMode == AuthMode.login) {
        // Log in provider
        await context.read<AuthProvider>().logIn(
              _authData['email']!,
              _authData['password']!,
            );
      } else {
        // Sign up provider
        await context.read<AuthProvider>().signUp(
              _authData['email']!,
              _authData['password']!,
            );
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication Failed';
      if (error.message.contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address already exists';
      } else if (error.message.contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.message.contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak';
      } else if (error.message.contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email';
      } else if (error.message.contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid Password';
      }
      errorDialog(errorMessage);
    } catch (error) {
      print(error);
      var errorMessage = 'Cannot authenticate. Please try again later';
      errorDialog(errorMessage);
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 8,
      child: Container(
        height: _authMode == AuthMode.signup ? 340 : 280,
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _authData['email'] = newValue!;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passCtrl,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password too short';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _authData['password'] = newValue!;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (_authMode == AuthMode.signup)
                  TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value != _passCtrl.text) {
                        return 'Password does not match!';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.0,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Sign In'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _authMode == AuthMode.login ? 'New user?' : 'Already have an account?',
                    ),
                    InkWell(
                      onTap: _switchAuthMode,
                      child: Text(
                        _authMode == AuthMode.login ? ' SignUp' : ' Login',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

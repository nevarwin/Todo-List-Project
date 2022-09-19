import 'package:flutter/material.dart';

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

  void _submit() {
    if (!_formKey.currentState!.validate()) {}
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
                  child: const Text('Submit'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _authMode == AuthMode.login
                          ? 'New user?'
                          : 'Already have an account?',
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

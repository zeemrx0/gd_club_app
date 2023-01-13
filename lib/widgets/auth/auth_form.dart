import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:provider/provider.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _isLogin = true;

  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _submitForm() async {
    if (_formKey.currentState != null) {
      bool isValid = _formKey.currentState!.validate();

      if (isValid) {
        _formKey.currentState!.save();

        try {
          if (_isLogin) {
            Provider.of<Auth>(context, listen: false)
                .signInWithEmailAndPassword(_email, _password);
          } else {
            Provider.of<Auth>(context, listen: false)
                .signUpWithEmailAndPassword(_email, _password);
          }
        } on PlatformException catch (e) {
          print(e);
        } catch (e) {
          print(e);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  _isLogin ? 'Đăng nhập' : 'Đăng kí',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  key: const ValueKey('email'),
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.all(12),
                    errorStyle: TextStyle(height: 0),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return '';
                    }

                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _email = newValue;
                    }
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  key: const ValueKey('password'),
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Mật khẩu',
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.all(12),
                    errorStyle: TextStyle(height: 0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '';
                    }

                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _password = newValue;
                    }
                  },
                  onChanged: (value) {
                    _password = value;
                  },
                ),
                if (!_isLogin)
                  const SizedBox(
                    height: 12,
                  ),
                if (!_isLogin)
                  TextFormField(
                    key: const ValueKey('confirmPassword'),
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Xác nhận mật khẩu',
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.all(12),
                      errorStyle: TextStyle(height: 0),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value != _password) {
                        return '';
                      }

                      return null;
                    },
                  ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    _submitForm();
                  },
                  child: Text(_isLogin ? 'Đăng nhập' : 'Đăng kí'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(_isLogin ? 'Tạo tài khoản' : 'Đã có tài khoản'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

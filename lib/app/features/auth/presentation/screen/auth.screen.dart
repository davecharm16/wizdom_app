import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wizdom_app/app/core/utils/extensions/auth.extension.dart';
import 'package:wizdom_app/app/features/auth/data/models/auth.model.dart';
import 'package:wizdom_app/app/features/auth/data/repo/auth.repository.dart';
import 'package:wizdom_app/app/features/auth/data/services/auth.service.dart';
import 'package:wizdom_app/app/features/auth/domain/provider/auth.provider.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  bool _isLogin = true;
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final Map<String, String> _authData = <String, String>{
    'email': '',
    'password': '',
    'name': '',
  };

  void _onSubmit() async {
    final AuthUser? user;
    final AuthRepository authentication = ref.read(authProvider);
    final bool isValid = form.currentState!.validate();
    if (!isValid) {
      form.currentState!.save();
      if (_isLogin) {
        user = await authentication.authenticateUser(
            _authData['email']!, _authData['password']!, AuthType.login);
      } else {
        user = await authentication.authenticateUser(
            _authData['email']!, _authData['password']!, AuthType.signUp,
            name: _authData['name']!);
      }

      if (user != null) {
        // Navigate to home screen
        log(user.email);
      } else {
        log('Error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'WizdomHUB',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: form,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: (String? value) => value!.validateEmail,
                            onSaved: (String? value) {
                              _authData['email'] = value!;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          if (!_isLogin) ...<Widget>[
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Name',
                              ),
                              validator: (String? value) => value!.validateName,
                              onSaved: (String? value) {
                                _authData['name'] = value!;
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                            validator: (String? value) =>
                                value!.validatePassword,
                            onSaved: (String? value) {
                              _authData['password'] = value!;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ElevatedButton(
                            onPressed: _onSubmit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onPrimary,
                            ),
                            child: Text(_isLogin ? 'LOGIN' : 'SIGN UP'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextButton(
                  onPressed: () {
                    setState(
                      () {
                        _isLogin = !_isLogin;
                      },
                    );
                  },
                  child: Text(
                    _isLogin
                        ? 'Create an account'.toUpperCase()
                        : 'I already have an account'.toUpperCase(),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?'.toUpperCase(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

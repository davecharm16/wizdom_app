import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wizdom_app/app/core/utils/extensions/auth.extension.dart';
import 'package:wizdom_app/app/core/utils/snackbars/error.snackbars.dart';
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
  bool _isLoading = false;
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final Map<String, String> _authData = <String, String>{
    'email': '',
    'password': '',
    'name': '',
  };

  void _onSubmit(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    final AuthRepository authentication = ref.read(authProvider);
    final bool isValid = form.currentState!.validate();
    if (isValid) {
      form.currentState!.save();

      final AuthUser? user = _isLogin
          ? ref.read(userProvider.notifier).state =
              await authentication.authenticateUser(
                  _authData['email']!, _authData['password']!, AuthType.login)
          : ref.read(userProvider.notifier).state =
              await authentication.authenticateUser(
                  _authData['email']!, _authData['password']!, AuthType.signUp,
                  name: _authData['name']!);

      log('${user?.email} ', name: 'AuthScreen');

      if (context.mounted) {
        setState(() {
          _isLoading = false;
        });

        if (user == null) {
          ErrorSnackBar(context: context, message: 'Authentication failed')
              .show();
        }
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
                            onPressed: () {
                              _onSubmit(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onPrimary,
                            ),
                            child: _isLoading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  )
                                : Text(_isLogin ? 'LOGIN' : 'SIGN UP'),
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

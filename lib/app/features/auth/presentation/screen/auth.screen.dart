import 'package:flutter/material.dart';
import 'package:wizdom_app/app/core/utils/extensions/auth.extension.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  final form = GlobalKey<FormState>();

  void _onSubmit() {
    final isValid = form.currentState!.validate();
    if (!isValid) {
      form.currentState!.save();

      return;
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
              children: [
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
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: (value) => value!.validateEmail,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          if (!_isLogin) ...[
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Name',
                              ),
                              validator: (value) => value!.validateName,
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
                            validator: (value) => value!.validatePassword,
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

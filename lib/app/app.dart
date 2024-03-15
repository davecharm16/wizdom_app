import 'package:flutter/material.dart';
import 'package:wizdom_app/app/core/theme/theme.dart';
import 'package:wizdom_app/app/features/auth/presentation/screen/auth.screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wizdom',
      theme: themeData,
      home: const AuthScreen(),
    );
  }
}

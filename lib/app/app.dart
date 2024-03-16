import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wizdom_app/app/core/theme/theme.dart';
import 'package:wizdom_app/app/features/auth/domain/provider/auth.provider.dart';
import 'package:wizdom_app/app/features/auth/presentation/screen/auth.screen.dart';
import 'package:wizdom_app/app/features/home/presentation/screens/home.screen.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<User?> authChanges = ref.watch(authStateChangesProvider);

    return MaterialApp(
      title: 'Wizdom',
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: authChanges.when(
        data: (User? user) {
          if (user == null) {
            return const AuthScreen();
          }
          return const HomeScreen();
        },
        loading: () => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        error: (Object error, StackTrace? stackTrace) {
          return Center(
            child: Text('Error ${error.toString()}'),
          );
        },
      ),
    );
  }
}

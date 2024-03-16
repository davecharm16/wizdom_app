import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wizdom_app/app/features/auth/data/models/auth.model.dart';
import 'package:wizdom_app/app/features/auth/domain/provider/auth.provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthUser? user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              // Sign Out
              ref.read(authProvider).signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to WizdomHUB user ${user?.email ?? 'Unknown'}'),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:wizdom_app/app/features/auth/data/models/auth.model.dart';
import 'package:wizdom_app/app/features/auth/data/services/auth.service.dart';

abstract class AuthRepository {
  Future<AuthUser?> authenticateUser(
      String email, String password, AuthType type,
      {String? name});

  Stream<User?> authStateChanges();

  Future<void> signOut();
}

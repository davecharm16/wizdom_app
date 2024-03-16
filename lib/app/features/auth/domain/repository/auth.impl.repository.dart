import 'package:firebase_auth/firebase_auth.dart';
import 'package:wizdom_app/app/features/auth/data/models/auth.model.dart';
import 'package:wizdom_app/app/features/auth/data/repo/auth.repository.dart';
import 'package:wizdom_app/app/features/auth/data/services/auth.service.dart';

class AuthImplRepository implements AuthRepository {
  const AuthImplRepository({required this.service});
  final AuthService service;

  @override
  Future<AuthUser?> authenticateUser(
      String email, String password, AuthType type,
      {String? name}) async {
    return await service.authenticateUser(email, password, type, name: name);
  }

  @override
  Stream<User?> authStateChanges() {
    return service.authStateChanges();
  }

  @override
  Future<void> signOut() async {
    await service.signOut();
  }
}

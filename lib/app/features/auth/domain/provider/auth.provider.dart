import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wizdom_app/app/features/auth/data/repo/auth.repository.dart';
import 'package:wizdom_app/app/features/auth/data/services/auth.service.dart';
import 'package:wizdom_app/app/features/auth/domain/repository/auth.impl.repository.dart';

final Provider<AuthService> authServiceProvider = Provider<AuthService>(
  (ProviderRef<AuthService> ref) {
    return AuthService();
  },
);

final Provider<AuthRepository> authProvider =
    Provider<AuthRepository>((ProviderRef<AuthRepository> ref) {
  return AuthImplRepository(service: ref.read(authServiceProvider));
});

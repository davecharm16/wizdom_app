import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wizdom_app/app/features/auth/data/models/auth.model.dart';

enum AuthType {
  login,
  signUp,
}

class AuthService {
  AuthService({required this.authType});
  final AuthType authType;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<AuthUser?> authenticateUser(
      String email, String password, AuthType type) async {
    try {
      if (type == AuthType.login) {
        final userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        final user = await _firestore
            .collection('user')
            .doc(userCredential.user!.uid)
            .get();
        return AuthUser.fromJson(user.data()!);
      } else {
        final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await _firestore.collection('user').doc(userCredential.user!.uid).set({
          'email': email,
          'password': password,
        });

        final user = await _firestore
            .collection('user')
            .doc(userCredential.user!.uid)
            .get();
        return AuthUser.fromJson(user.data()!);
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}

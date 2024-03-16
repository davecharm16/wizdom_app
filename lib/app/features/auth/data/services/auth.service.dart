import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wizdom_app/app/features/auth/data/models/auth.model.dart';

enum AuthType {
  login,
  signUp,
}

class AuthService {
  AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<AuthUser?> authenticateUser(
      String email, String password, AuthType type,
      {String? name}) async {
    try {
      if (type == AuthType.login) {
        final UserCredential userCredential =
            await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        final DocumentSnapshot<Map<String, dynamic>> user = await _firestore
            .collection('user')
            .doc(userCredential.user!.uid)
            .get();
        return AuthUser.fromJson(user.data()!);
      } else {
        final UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await _firestore
            .collection('user')
            .doc(userCredential.user!.uid)
            .set(<String, String>{
          'email': email,
          'password': password,
          'name': name ?? '',
          'uid': userCredential.user!.uid,
        });

        final DocumentSnapshot<Map<String, dynamic>> user = await _firestore
            .collection('user')
            .doc(userCredential.user!.uid)
            .get();
        return AuthUser.fromJson(user.data()!);
      }
    } catch (e) {
      log(e.toString(), name: 'AuthService');
      return null;
    }
  }

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}

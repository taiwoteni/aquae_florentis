// ignore_for_file: use_build_context_synchronously
import 'package:aquae_florentis/app/platform.dart';
import 'package:aquae_florentis/app/routes-manager.dart';
import 'package:aquae_florentis/data/shared-preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppAuth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get user => _auth.currentUser;

  static Future<void> signOut({required BuildContext context}) async {
    await _auth.signOut();
    await AppStorage.deleteUser();
    Navigator.pushReplacementNamed(context,
        AppPlatform.isDesktop ? Routes.loginDesktopRoute : Routes.loginRoute);
  }

  static Future<User?> createUser(
      {required final String email, required final String password}) async {
    try {
      final userCredentials = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return userCredentials.user;
    } on FirebaseAuthException catch (exception) {
      print(exception);
      return null;
    }
  }

  static Future<User?> signIn(
      {required final String email, required final String password}) async {
    try {
      final userCredentials = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return userCredentials.user;
    } on FirebaseAuthException catch (exception) {
      print(exception);
      return null;
    }
  }
}

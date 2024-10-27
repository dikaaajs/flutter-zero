// auth_provider.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Auth_Provider with ChangeNotifier {
  bool _isLoggedIn = false;
  User? _user; // Menyimpan data pengguna

  bool get isLoggedIn => _isLoggedIn;
  User? get user => _user; // Getter untuk mengakses data user

  Auth_Provider() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _isLoggedIn = user != null;
      _user = user;
      notifyListeners();
    });
  }

  // Fungsi logout
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _isLoggedIn = false;
    _user = null; // Reset data user saat logout
    notifyListeners();
  }
}

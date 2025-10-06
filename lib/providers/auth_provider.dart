import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  final bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;

  // Methods for login, register, logout
}

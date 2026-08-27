import 'dart:math';
import 'package:flutter/foundation.dart';

class AuthService {
  bool _isAuthenticated = false;
  String? _userEmail;
  String? _lastGeneratedCode;

  bool get isAuthenticated => _isAuthenticated;
  String? get userEmail => _userEmail;

  /// Step 1: Send Magic Login link or One-Time Passcode (OTP) to user email
  Future<String> sendMagicLoginCode(String email) async {
    if (email.isEmpty || !email.contains('@')) {
      throw Exception('Invalid email address provided for Magic Login.');
    }
    
    // Generate a secure 6-digit pure Dart random passcode
    final random = Random();
    _lastGeneratedCode = (100000 + random.nextInt(900000)).toString();
    _userEmail = email;

    // Pure Dart local simulation of dispatching email verification code
    debugPrint('[Magic Login] Code sent to $email: $_lastGeneratedCode');
    return _lastGeneratedCode!;
  }

  /// Step 2: Verify Magic Login Code and authenticate user
  bool verifyMagicLoginCode(String enteredCode) {
    if (_lastGeneratedCode != null && enteredCode == _lastGeneratedCode) {
      _isAuthenticated = true;
      return true;
    }
    return false;
  }

  Future<void> signOut() async {
    _isAuthenticated = false;
    _userEmail = null;
    _lastGeneratedCode = null;
  }
}

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<User> login({
    required String email,
    required String password,
  });
  Future<User> signUp({
    required String email,
    required String password,
    required String fullName,
  });
  Future<void> logout();
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/features/auth/data/data_source/remote_data_source.dart';
import 'package:my_app/features/auth/data/repo/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  AuthRemoteDataSource remoteDataSource;
  AuthRepoImp({required this.remoteDataSource});

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    return await remoteDataSource.login(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }

  @override
  Future<User> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    return await remoteDataSource.signUp(
      email: email,
      password: password,
      fullName: fullName,
    );
  }
}

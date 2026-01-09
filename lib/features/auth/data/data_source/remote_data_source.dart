import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/core/utils/logger.dart';
import 'package:my_app/features/auth/data/data_source/local_data_source.dart';

abstract class AuthRemoteDataSource {
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

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final AuthLocalDataSource localDataSource;

  AuthRemoteDataSourceImpl({
    required this.localDataSource,
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user!;

    await _ensureUserDocument(
      user,
    );
    await localDataSource.cacheUser(user);
    return user;
  }

  @override
  Future<User> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user!;
    await user.updateDisplayName(fullName);
    await user.reload();
    await _ensureUserDocument(user, fullName: fullName);

    return user;
  }

  @override
  Future<void> logout() async {
    Future.wait([firebaseAuth.signOut(), localDataSource.removeCachedUser()]);
  }

  Future<void> _ensureUserDocument(User user, {String? fullName}) async {
    final userDocRef = firestore.collection('users').doc(user.uid);
    final userDoc = await userDocRef.get();

    AppLogger.debug('User document $fullName', 'displayName');
    if (!userDoc.exists) {
      await userDocRef.set({
        'uid': user.uid,
        'fullName': fullName ?? '',
        'email': user.email ?? '',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }
}

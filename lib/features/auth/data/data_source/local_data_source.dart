import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/core/constants/app_constants.dart';
import 'package:my_app/core/storage/secure_storage.dart';
import 'package:my_app/core/utils/logger.dart';
import 'package:my_app/features/auth/data/models/user.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(User user);
  Future<AppUser?> getCachedUser();
  Future<void> removeCachedUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorage _cacheService;
  AuthLocalDataSourceImpl(this._cacheService);
  @override
  Future<void> cacheUser(User user) {
    AppUser appUser = AppUser.fromFirebaseUser(user);
    return _cacheService.write(
        AppConstants.keyUserCache, jsonEncode(appUser.toJson()));
  }

  @override
  Future<AppUser?> getCachedUser() async {
    final jsonString = await _cacheService.read(AppConstants.keyUserCache);

    if (jsonString == null) {
      return null;
    }

    try {
      final Map<String, dynamic> userMap = jsonDecode(jsonString);
      final cachedUser = AppUser.fromJson(userMap);
      return cachedUser;
    } catch (e) {
      AppLogger.error('Failed to parse cached user', e, null, 'Cache');
      return null;
    }
  }

  @override


  Future<void> removeCachedUser() {
    return _cacheService.delete(AppConstants.keyUserCache);
  }
}

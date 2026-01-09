import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_app/core/utils/logger.dart';
import 'package:my_app/features/auth/data/models/user.dart';
import 'package:my_app/features/home/data/repo/user_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserStates> {
  final UserRepo _repo;
  UserCubit(this._repo) : super(UserStates());

  int currentIndex = 0;
  StreamSubscription<List<AppUser>>? _usersSub;

  Future<void> changeTab(int index) async {
    if (index == currentIndex) return;

    emit(state.copyWith(status: UserState.loadingChangeIndex));

    currentIndex = index;

    emit(state.copyWith(status: UserState.changeIndex));
    AppLogger.debug('Current Index: $currentIndex');
  }

  void getUsers({String? query, int? limit}) {
    emit(state.copyWith(status: UserState.loading));

    _usersSub?.cancel();

    _usersSub = _repo
        .getUsers(
      query: query,
      limit: limit,
    )
        .listen(
      (users) {
        emit(
          state.copyWith(
            status: UserState.userLoaded,
            users: users,
          ),
        );
      },
      onError: (e) {
        emit(
          state.copyWith(
            status: UserState.error,
            message: e.toString(),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _usersSub?.cancel();
    return super.close();
  }
}

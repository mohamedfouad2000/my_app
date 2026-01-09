part of 'user_cubit.dart';

enum UserState { initial, loadingChangeIndex,changeIndex, loading, userLoaded, error }

/// Extension على UserStates مش على UserState
extension UserStatesX on UserStates {
  bool get isInitial => status == UserState.initial;
  bool get isLoading => status == UserState.loading;
  bool get isUserLoaded => status == UserState.userLoaded;
  bool get isError => status == UserState.error;
  bool get isChangeIndex => status == UserState.changeIndex;
  bool get isLoadingChangeIndex => status == UserState.loadingChangeIndex;
}

@immutable 
class UserStates {
  final UserState status;
  final String? message;
  final List<AppUser>? users;

  const UserStates({
    this.status = UserState.initial,
    this.users,
    this.message,
  });

  UserStates copyWith({
    UserState? status,
    List<AppUser>? users,
    String? message,
  }) {
    return UserStates(
      status: status ?? this.status,
      users: users ?? this.users,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return 'UserStates(status: $status, users: $users, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserStates &&
        other.status == status &&
        other.users == users &&
        other.message == message;
  }

  @override
  int get hashCode {
    return status.hashCode ^ users.hashCode ^ message.hashCode;
  }
}

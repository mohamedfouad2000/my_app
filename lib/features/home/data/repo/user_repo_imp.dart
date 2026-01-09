import 'package:my_app/features/auth/data/models/user.dart';
import 'package:my_app/features/home/data/data_source/remote_data_source.dart';
import 'package:my_app/features/home/data/repo/user_repo.dart';

class UserRepoImp implements UserRepo {
  final HomeRemoteDataSource remoteDataSource;

  UserRepoImp({required this.remoteDataSource});

  @override
  Stream<List<AppUser>> getUsers({String? query, int? limit}) {
    return remoteDataSource.getUsersStream(query: query, limit: limit);
  }
}

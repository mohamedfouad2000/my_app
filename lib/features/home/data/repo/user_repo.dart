import 'package:my_app/features/auth/data/models/user.dart';

abstract class UserRepo {
  Stream<List<AppUser>> getUsers({String? query, int? limit});
}

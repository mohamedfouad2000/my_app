import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/features/auth/data/models/user.dart';

abstract class HomeRemoteDataSource {
  Stream<List<AppUser>> getUsersStream({String? query, int? limit});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore _firestore;

  HomeRemoteDataSourceImpl(this._firestore);

  @override
  Stream<List<AppUser>> getUsersStream({String? query, int? limit = 20}) {
    Query usersQuery =
        _firestore.collection('users').orderBy('fullName').limit(limit ?? 20);

    if (query != null && query.isNotEmpty) {
      final end = '$query\uf8ff';
      usersQuery = usersQuery
          .where('fullName', isGreaterThanOrEqualTo: query)
          .where('fullName', isLessThanOrEqualTo: end);
    }

    return usersQuery.snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map(
                  (doc) => AppUser.fromJson(doc.data() as Map<String, dynamic>))
              .toList(),
        );
  }
}

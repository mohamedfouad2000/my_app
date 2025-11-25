import 'package:dartz/dartz.dart';
import 'package:my_app/core/errors/failures.dart';
import 'package:my_app/core/network/network_info.dart';
import 'package:my_app/core/utils/hanlders/repo_impl_callhandler.dart';
import 'package:my_app/features/listing/data/data_source/remote_data_source.dart';
import 'package:my_app/features/listing/data/models/nex_media_model.dart';
import 'package:my_app/features/listing/domain/repo/repo_imp.dart';

class BftxNexRepoImpl implements BftxNexRepo {
  final BftxNexRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  BftxNexRepoImpl({required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, List<NexMediaModel>>> getAllNex() async {
    return await RepoImplCallHandler<List<NexMediaModel>>(networkInfo)(
        () async {
      final result = await remoteDataSource.getAllNex();
      return result;
    });
  }
}

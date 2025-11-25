import 'package:dartz/dartz.dart';
import 'package:my_app/core/errors/failures.dart';
import 'package:my_app/core/usecase/usecase.dart';
import 'package:my_app/features/listing/data/models/nex_media_model.dart';
import 'package:my_app/features/listing/domain/repo/repo_imp.dart';

class GetAllNexUseCase implements UseCase<List<NexMediaModel>, NoParams> {
  final BftxNexRepo repository;

  GetAllNexUseCase({required this.repository});

  @override
  Future<Either<Failure, List<NexMediaModel>>> call(NoParams params) async {
    return await repository.getAllNex();
  }
}

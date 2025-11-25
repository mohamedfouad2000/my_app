import 'package:dartz/dartz.dart';
import 'package:my_app/core/errors/failures.dart';
import 'package:my_app/features/listing/data/models/nex_media_model.dart';

abstract class BftxNexRepo {
  Future<Either<Failure, List<NexMediaModel>>> getAllNex();
}

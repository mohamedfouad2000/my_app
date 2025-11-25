import 'package:my_app/core/api/api_client.dart';
import 'package:my_app/core/constants/api_endpoints.dart';
import 'package:my_app/core/utils/hanlders/remote_data_source_handler.dart';
import 'package:my_app/features/listing/data/models/nex_media_model.dart';

abstract class BftxNexRemoteDataSource {
  Future<List<NexMediaModel>> getAllNex();
}

class BftxNexRemoteDataSourceImpl implements BftxNexRemoteDataSource {
  final ApiClient networkManager;
  BftxNexRemoteDataSourceImpl({required this.networkManager});
  @override
  Future<List<NexMediaModel>> getAllNex() async {
    final response = await networkManager.get(
      ApiEndpoints.nexAllEndPoint,
    );
    final data = await RemoteDataSourceCallHandler()(response);
    if (data.data == []) {
      return [];
    }
    return (data.data as List<dynamic>)
        .map((e) => NexMediaModel.fromJson(e))
        .toList();
    // try {
    //   return (data.data as List<dynamic>)
    //       .map((e) => NexMediaModel.fromJson(e))
    //       .toList();
    // } catch (e) {
    //   throw DataParsingException(
    //     'Type mismatch or invalid data: ${e.runtimeType} - ${e.toString()}',
    //     data.data,
    //   );
  }
}

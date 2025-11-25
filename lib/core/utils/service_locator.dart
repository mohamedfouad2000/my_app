import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:my_app/core/api/api_client.dart';
import 'package:my_app/core/config/app_config.dart';
import 'package:my_app/core/network/network_info.dart';
import 'package:my_app/features/listing/data/data_source/remote_data_source.dart';
import 'package:my_app/features/listing/data/repo_imp/bftx_nex_repo_impl.dart';
import 'package:my_app/features/listing/domain/repo/repo_imp.dart';
import 'package:my_app/features/listing/domain/use_cases/get_all_nex_use_case.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    sl.registerLazySingleton<AppConfig>(() => AppConfig.load());

    // 2️⃣ Connectivity
    sl.registerLazySingleton<Connectivity>(() => Connectivity());
    sl.registerLazySingleton<InternetConnection>(() => InternetConnection());

    // 3️⃣ Network Info
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

    // 4️⃣ Api Client
    sl.registerLazySingleton<ApiClient>(() => ApiClient(sl()));

    //data sources
    sl.registerLazySingleton<BftxNexRemoteDataSource>(
      () => BftxNexRemoteDataSourceImpl(networkManager: sl()),
    );

    // repositories
    sl.registerLazySingleton<BftxNexRepo>(
      () => BftxNexRepoImpl(remoteDataSource: sl(), networkInfo: sl()),
    );
    //use cases
    sl.registerLazySingleton<GetAllNexUseCase>(
      () => GetAllNexUseCase(repository: sl()),
    );
  }
}

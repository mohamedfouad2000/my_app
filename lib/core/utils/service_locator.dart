import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:my_app/core/api/api_client.dart';
import 'package:my_app/core/network/network_info.dart';
import 'package:my_app/core/storage/secure_storage.dart';
import 'package:my_app/features/auth/data/data_source/local_data_source.dart';
import 'package:my_app/features/auth/data/data_source/remote_data_source.dart';
import 'package:my_app/features/auth/data/repo/auth_repo.dart';
import 'package:my_app/features/auth/data/repo/auth_repo_imp.dart';
import 'package:my_app/features/auth/presenation/cubit/auth_cubit.dart';
import 'package:my_app/features/home/data/data_source/remote_data_source.dart';
import 'package:my_app/features/home/data/repo/user_repo.dart';
import 'package:my_app/features/home/data/repo/user_repo_imp.dart';
import 'package:my_app/features/home/presentation/cubit/user_cubit.dart';
import 'package:my_app/features/listing/data/data_source/remote_data_source.dart';
import 'package:my_app/features/listing/data/repo_imp/bftx_nex_repo_impl.dart';
import 'package:my_app/features/listing/domain/repo/repo_imp.dart';
import 'package:my_app/features/listing/domain/use_cases/get_all_nex_use_case.dart';

final sl = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    sl.registerLazySingleton<SecureStorage>(() => SecureStorage.instance);
    sl.registerLazySingleton<FirebaseAuth>(
      () => FirebaseAuth.instance,
    );

    sl.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );
    sl.registerLazySingleton<Connectivity>(() => Connectivity());
    sl.registerLazySingleton<InternetConnection>(() => InternetConnection());

    // 3️⃣ Network Info
    sl.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(sl<InternetConnection>()));

    // 4️⃣ Api Client
    sl.registerLazySingleton<ApiClient>(() => ApiClient());

    //data sources
    sl.registerLazySingleton<BftxNexRemoteDataSource>(
      () => BftxNexRemoteDataSourceImpl(networkManager: sl()),
    );
    sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sl<SecureStorage>()),
    );
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        localDataSource: sl<AuthLocalDataSource>(),
        firebaseAuth: sl<FirebaseAuth>(),
        firestore: sl<FirebaseFirestore>(),
      ),
    );
    sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(sl<FirebaseFirestore>()),
    );

    // repositories
    sl.registerLazySingleton<BftxNexRepo>(
      () => BftxNexRepoImpl(remoteDataSource: sl(), networkInfo: sl()),
    );
    sl.registerLazySingleton<UserRepo>(
      () => UserRepoImp(remoteDataSource: sl()),
    );

    sl.registerLazySingleton<AuthRepo>(
      () => AuthRepoImp(remoteDataSource: sl()),
    );

    //use cases
    sl.registerLazySingleton<GetAllNexUseCase>(
      () => GetAllNexUseCase(repository: sl()),
    );

    // cubits
    sl.registerLazySingleton<UserCubit>(
      () => UserCubit(sl()),
    );
    sl.registerLazySingleton<AuthCubit>(
      () => AuthCubit(sl()),
    );
  }
}

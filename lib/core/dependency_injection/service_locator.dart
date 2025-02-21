import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:clean_arch_project/core/network/api_client.dart';
import 'package:clean_arch_project/core/usecases/usecase.dart';
import 'package:clean_arch_project/features/user/data/datasources/local_data_source.dart';
import 'package:clean_arch_project/features/user/data/datasources/base_data_source.dart';
import 'package:clean_arch_project/features/user/data/datasources/remote_data_source.dart';
import 'package:clean_arch_project/features/user/data/repositories_impl/user_repository_impl.dart';
import 'package:clean_arch_project/features/user/domain/repositories/user_repository.dart';
import 'package:clean_arch_project/features/user/domain/entities/user.dart';
import 'package:clean_arch_project/features/user/domain/usecases/get_users.dart';
import 'package:clean_arch_project/features/user/domain/usecases/clear_cache.dart';
import 'package:clean_arch_project/features/user/presentation/bloc/user_bloc.dart';

final GetIt sl = GetIt.instance;

void init() {
  //managing dependencies by registering Singleton instances and bloc into dependency
  //injection container

  sl
    //Registering an ApiClient to provide an instance for api calls
    ..registerLazySingleton(() => ApiClient())

    //Registering RemoteDataSource and passing the registered instance of ApiClient
    ..registerLazySingleton<BaseUserDataSource>(
        () => UserRemoteDataSourceImpl(sl<ApiClient>()),
        instanceName: 'remote')

    //Registering Local Data Source for getting data from cache
    ..registerLazySingleton<BaseUserDataSource>(() => UserLocalDataSourceImpl(),
        instanceName: 'local')

    //Registering UserRepository and passing the registered instance of RemoteDataSource
    ..registerLazySingleton<BaseUserRepository>(
      () => UserRepositoryImpl(
        remoteDataSource: sl<BaseUserDataSource>(instanceName: 'remote'),
        localDataSource: sl<BaseUserDataSource>(instanceName: 'local'),
      ),
    )

    //Registering GetUsers Use Case and passing the registered instance of BaseUserRepository
    ..registerLazySingleton<BaseUseCase<List<User>, NoParams>>(
        () => GetUsers(sl<BaseUserRepository>()))

    //Registering Clear Users Cache Use Case
    ..registerLazySingleton<BaseUseCase<Unit, NoParams>>(
      () => ClearCache(sl<BaseUserRepository>()),
    )

    //Registering Bloc for Users state management and passing the registered instance of BaseUseCase
    ..registerFactory(() => UserBloc(
          getUsers: sl<BaseUseCase<List<User>, NoParams>>(),
          clearCache: sl<BaseUseCase<Unit, NoParams>>(),
        ));
}

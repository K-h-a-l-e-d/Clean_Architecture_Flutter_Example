import 'dart:convert';
import 'package:clean_arch_project/core/error/exceptions.dart';
import 'package:clean_arch_project/core/error/failures.dart';
import 'package:clean_arch_project/features/user/data/datasources/base_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

//User Repo implementation fetches users from local storage if it exists otherwise  api users are fetched
//also implements Clear Cached users function
class UserRepositoryImpl implements BaseUserRepository {
  //both remote and local data source source are handled by the dependency injection container
  //using their names to call their respective implementations
  final BaseUserDataSource remoteDataSource;
  final BaseUserDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    try {
      final cachedUsers = await localDataSource.getUsers();

      if (cachedUsers.isNotEmpty) {
        return Right(cachedUsers);
      } else {
        final remoteUsers = await remoteDataSource.getUsers();
        await cacheUsers(remoteUsers);
        return Right(remoteUsers);
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> cacheUsers(List<User> users) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        'users',
        //converting from List<User> to List<String> then storing
        users.map((user) => jsonEncode(user)).toList(),
      );
      return Right(unit);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearCache() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Clearing all data in local storage
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure('Failed to clear cache: ${e.toString()}'));
    }
  }
}

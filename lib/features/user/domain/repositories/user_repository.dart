import 'package:clean_arch_project/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../entities/user.dart';

//Base Repo Class which will be used to get users either from
//remote or local data source
abstract class BaseUserRepository {
  Future<Either<Failure, List<User>>> getUsers();
  Future<Either<Failure, Unit>> cacheUsers(List<User> users);
  Future<Either<Failure, Unit>> clearCache();
}

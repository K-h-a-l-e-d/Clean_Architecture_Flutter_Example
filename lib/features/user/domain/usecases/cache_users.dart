import 'package:clean_arch_project/core/error/failures.dart';
import 'package:clean_arch_project/core/usecases/usecase.dart';
import 'package:clean_arch_project/features/user/domain/entities/user.dart';
import 'package:clean_arch_project/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class CacheUsers implements BaseUseCase<Unit, List<User>> {
  final BaseUserRepository repository;

  CacheUsers(this.repository);

  @override
  Future<Either<Failure, Unit>> call(List<User> user) async {
    return await repository.cacheUsers(user);
  }
}

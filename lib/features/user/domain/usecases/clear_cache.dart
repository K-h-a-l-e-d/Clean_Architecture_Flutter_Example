import 'package:dartz/dartz.dart';
import 'package:clean_arch_project/core/error/failures.dart';
import 'package:clean_arch_project/core/usecases/usecase.dart';
import 'package:clean_arch_project/features/user/domain/repositories/user_repository.dart';

class ClearCache implements BaseUseCase<Unit, NoParams> {
  final BaseUserRepository repository;

  ClearCache(this.repository);
  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await repository.clearCache();
  }
}

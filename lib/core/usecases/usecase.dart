import 'package:clean_arch_project/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class BaseUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

//this class is Used for cases that don't require parameters
class NoParams {}

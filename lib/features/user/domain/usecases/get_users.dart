import 'package:clean_arch_project/core/error/failures.dart';
import 'package:clean_arch_project/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

//GetUsers is our project's Use Case and here it overrides
//our abstract class BaseUseCase dart's call method (which allows an instance of any class that defines it to emulate a function)
//and inside the call method getusers is called from repositry instance since users can be fetched either
//from a remote data source or a local cache
class GetUsers implements BaseUseCase<List<User>, NoParams> {
  final BaseUserRepository repository;

  GetUsers(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(NoParams noParams) async {
    return await repository.getUsers();
  }
}

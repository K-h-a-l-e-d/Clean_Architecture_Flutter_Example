import 'package:clean_arch_project/core/error/failures.dart';
import 'package:clean_arch_project/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final BaseUseCase<List<User>, NoParams> getUsers;
  final BaseUseCase<Unit, NoParams> clearCache;
  UserBloc({required this.getUsers, required this.clearCache})
      : super(UserInitial()) {
    on<FetchUsers>(_fetchUsers);

    on<ClearCachedUsers>(_clearCache);
  }

  Future<void> _fetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    //getting GetUsers singleton instance instance from dependency injection container
    final Either<Failure, List<User>> result = await getUsers.call(NoParams());
    //dartz's fold function is called which emits Either's
    //Right parameter which is the returned List of users in our case in case of a successful fetch
    //or the Left Parameter which is the returned Failure status
    result.fold(
      (failure) => emit(UserError(failure.message)),
      (users) => emit(UserLoaded(users)),
    );
  }

  Future<void> _clearCache(
      ClearCachedUsers event, Emitter<UserState> emit) async {
    final Either<Failure, Unit> result = await clearCache.call(NoParams());
    result.fold(
      (failure) => emit(
          UserError(failure.message)), // Emit error if cache clearing fails
      (_) => emit(CacheCleared()), // Emit success state if cache is cleared
    );
  }
}

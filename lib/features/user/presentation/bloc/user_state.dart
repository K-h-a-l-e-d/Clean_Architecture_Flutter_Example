part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {
  //here we use equatable to compare between 2 instances to see
  //if both are the same instance depending on their imternal properties specified in props list
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;

  UserLoaded(this.users);

  //passing users to equatable's object comparision properties
  @override
  List<Object?> get props => [users];
}

class UserError extends UserState {
  final String message;

  UserError(this.message);

  @override
  List<Object?> get props => [message];
}

class CacheCleared extends UserState {}

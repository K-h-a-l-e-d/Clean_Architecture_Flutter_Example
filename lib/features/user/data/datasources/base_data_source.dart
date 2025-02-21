import 'package:clean_arch_project/features/user/data/models/user_model.dart';

abstract class BaseUserDataSource {
  Future<List<UserModel>> getUsers();
}

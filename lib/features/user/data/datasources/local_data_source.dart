import 'dart:convert';
import 'package:clean_arch_project/features/user/data/datasources/base_data_source.dart';
import 'package:clean_arch_project/features/user/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalDataSourceImpl implements BaseUserDataSource {
  @override
  Future<List<UserModel>> getUsers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final usersStringList = prefs.getStringList('users');

    if (usersStringList != null && usersStringList.isNotEmpty) {
      return usersStringList
          .map((usersStringList) =>
              UserModel.fromJson(jsonDecode(usersStringList)))
          .toList();
    } else {
      return [];
    }
  }
}

import 'package:clean_arch_project/core/error/exceptions.dart';
import 'package:clean_arch_project/core/network/api_client.dart';
import 'package:clean_arch_project/features/user/data/datasources/base_data_source.dart';
import 'package:clean_arch_project/features/user/data/models/user_model.dart';
import 'package:dio/dio.dart';

class UserRemoteDataSourceImpl implements BaseUserDataSource {
  final ApiClient apiClient;

  UserRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<UserModel>> getUsers() async {
    final Response response = await apiClient.get(NetworkConstants.usersApi);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = response.data;
      return jsonData.map((jsonMap) => UserModel.fromJson(jsonMap)).toList();
    } else {
      throw ServerException(
          message: 'Failed to load users',
          statusCode: '${response.statusCode}');
    }
  }
}

import 'package:dio/dio.dart';

abstract class NetworkConstants {
  static String usersApi = 'https://jsonplaceholder.typicode.com/users';
}

class ApiClient {
  final Dio _dio = Dio();

  Future<Response> get(String url) async {
    try {
      return await _dio.get(url);
    } on DioException catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}

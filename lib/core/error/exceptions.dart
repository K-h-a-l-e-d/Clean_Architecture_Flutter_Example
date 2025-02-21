class ServerException implements Exception {
  final String message;
  final String statusCode;

  ServerException({required this.statusCode, required this.message});
}

class CacheException implements Exception {
  final String message;

  CacheException({required this.message});
}

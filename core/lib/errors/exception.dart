class ServerException implements Exception {
  ServerException({required this.message});

  final String message;
}

class DatabaseException implements Exception {
  DatabaseException(this.message);

  final String message;
}

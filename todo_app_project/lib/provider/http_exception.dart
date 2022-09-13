class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  String toStrint() {
    return message;
  }
}

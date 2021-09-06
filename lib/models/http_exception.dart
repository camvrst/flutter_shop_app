class HttpException implements Exception {
  // implements uses a class & force to use all the methods this class has
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    return message;
  }
}
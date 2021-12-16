class HttpsException implements Exception {
  final String exception;

  HttpsException(this.exception);

  @override
  String toString() {
    print("Exception occured::" + exception);

    return exception;
  }
}

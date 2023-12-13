class NotFoundException implements Exception {
  final String message;

  NotFoundException(this.message);
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(this.message);
}

import 'package:greycells/constants/strings.dart';

class HttpException implements Exception {
  final _message;

  HttpException(this._message);

  String toString() {
    return "$_message";
  }
}

class FetchDataException extends HttpException {
  FetchDataException() : super("Unable to connect. Please try again.");
}

class BadRequestException extends HttpException {
  BadRequestException() : super(ErrorMessages.GENERIC_ERROR_MESSAGE);
}

class UnauthorisedException extends HttpException {
  UnauthorisedException() : super("Unauthorised");
}

class ResourceNotFoundException extends HttpException {
  ResourceNotFoundException() : super("Not found");
}

class ResourceConflictException extends HttpException {
  ResourceConflictException() : super("Conflict in resource");
}

class UnknownResponseCodeException extends HttpException {
  UnknownResponseCodeException() : super(ErrorMessages.GENERIC_ERROR_MESSAGE);
}

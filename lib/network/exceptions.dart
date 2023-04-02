
import 'package:dio/dio.dart';

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r, Response<dynamic> re) : super(requestOptions: r,response: re);

  @override
  String toString() {
    return  response?.data["message"];
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r, Response<dynamic> re) : super(requestOptions: r,response: re);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r, Response<dynamic> re) : super(requestOptions: r,response: re);

  @override
  String toString() {
    return  response?.data["message"];
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r, Response<dynamic> re) : super(requestOptions: r,response: re);

  @override
  String toString() {
    return  response?.data["message"];
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r, Response<dynamic> re) : super(requestOptions: r,response: re);

  @override
  String toString() {
    return  response?.data["message"];
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}
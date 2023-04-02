import 'package:dio/dio.dart';

import 'exceptions.dart';

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {

    // options.headers["x-api-key"] = "8266f169e301566feee9aee5518c7455";
    return handler.next(options);
  }
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions,  err.response!);
          case 401:
            throw UnauthorizedException(err.requestOptions,  err.response!);
            case 403:
            throw UnauthorizedException(err.requestOptions,  err.response!);
          case 404:
            throw NotFoundException(err.requestOptions,  err.response!);
          case 409:
            throw ConflictException(err.requestOptions,  err.response!);
          case 500:
            throw InternalServerErrorException(err.requestOptions,  err.response!);
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw NoInternetConnectionException(err.requestOptions);
    }

    return handler.next(err);
  }
}
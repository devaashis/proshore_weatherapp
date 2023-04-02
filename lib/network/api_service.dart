import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:proshore_weather_app/util/app_constants.dart';

import 'interceptors.dart';

enum Method { GET, POST }

class APIService {
  final dio = createDio();

  APIService._internal();

  static final _singleton = APIService._internal();

  factory APIService() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseURl,
      receiveTimeout: 15000, // 15 seconds
      connectTimeout: 15000,
      sendTimeout: 15000,
    ));

    dio.interceptors.addAll({
      PrettyDioLogger(),
      AppInterceptors(Dio(BaseOptions(
          baseUrl: AppConstants.baseURl))),
    });
    return dio;
  }

  Future<dynamic> request(
      Method method, String endPoint, data) async {
    Response response;
    try {
      switch (method) {
        case Method.GET:
          response = await dio?.get(endPoint,queryParameters: data) as Response;
          break;
        case Method.POST:
          response = await dio?.post(endPoint, data: data) as Response;
          break;
      }
      print(response.data);

        return response.data;

    } on DioError catch (e) {

      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
      rethrow;
    }
  }
}

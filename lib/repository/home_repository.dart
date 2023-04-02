import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:proshore_weather_app/util/app_constants.dart';
import 'package:proshore_weather_app/model/response_locations.dart';
import 'package:proshore_weather_app/model/response_weather.dart';
import 'package:proshore_weather_app/network/api_service.dart';

class HomeRepository {
  APIService apiService = APIService();

  Future<dynamic> getCityWeather(
      {required String cityName}) async {
    try {
      var params = {
        "q": "$cityName",
        "units": "metric",
        "appid": "${AppConstants.apiKey}",
      };

      Map<String, dynamic> response =
      await apiService.request(Method.GET, AppConstants.weather, params);
      return ResponseWeather.fromJson(response);
    } on DioError catch (e) {
      return e;
    }
  }
}

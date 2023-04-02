import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:proshore_weather_app/model/response_locations.dart';
import 'package:proshore_weather_app/model/response_weather.dart';
import 'package:proshore_weather_app/repository/home_repository.dart';
import 'package:proshore_weather_app/widgets/my_snackbar.dart';

enum STATUS { initial, loading, error, success, noInternet, reload }

enum WeatherCondition {
  thunderstorm,
  drizzle,
  rain,
  snow,
  atmosphere,
  mist,
  fog,
  lightCloud,
  heavyCloud,
  clear,
  unknown
}

class HomeProvider extends ChangeNotifier {
  HomeRepository repository = HomeRepository();
  ListElement? selectedWeather;

  STATUS _pageStatus = STATUS.initial;
  String errorMessage = "";
  String cityName = "";
  bool _reload = false;

  bool get reload => _reload;

  set reload(bool value) {
    _reload = value;
    notifyListeners();
  }

  STATUS get pageStatus => _pageStatus;

  set pageStatus(STATUS value) {
    _pageStatus = value;
    notifyListeners();
  }

  validateCityName(BuildContext context, String cityName) {
    if (cityName.isEmpty) {
      MySnackBar(context: context).show("Empty City");
      return false;
    } else if (cityName.length < 4) {
      MySnackBar(context: context)
          .show("City name must be atleast 4 character ");
      return false;
    }
    return true;
  }

  Future<dynamic> getWeather(String cityName) async {
    if (pageStatus != STATUS.loading) {
      pageStatus = STATUS.loading;
    }
    dynamic response = await repository.getCityWeather(cityName: cityName);
    if (response is ResponseWeather) {
      selectedWeather = response.list?.first;
      return response;
    } else if (response is DioError) {
      errorMessage = response.toString();
      return errorMessage;
    }
    return true;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return 'thunder';
    } else if (condition < 400) {
      return 'drizzle';
    } else if (condition == 500) {
      return 'rain';
    } else if (condition < 600) {
      return 'heavy_rain';
    } else if (condition < 700) {
      return 'snow';
    } else if (condition < 800) {
      return 'fog';
    } else if (condition == 800) {
      return 'sun';
    } else if (condition <= 804) {
      return 'cloud';
    } else {
      return 'thermometer';
    }
  }

  static WeatherCondition mapStringToWeatherCondition(String input,
      int cloudiness) {
    WeatherCondition condition;
    switch (input) {
      case 'Thunderstorm':
        condition = WeatherCondition.thunderstorm;
        break;
      case 'Drizzle':
        condition = WeatherCondition.drizzle;
        break;
      case 'Rain':
        condition = WeatherCondition.rain;
        break;
      case 'Snow':
        condition = WeatherCondition.snow;
        break;
      case 'Clear':
        condition = WeatherCondition.clear;
        break;
      case 'Clouds':
        condition = (cloudiness >= 85)
            ? WeatherCondition.heavyCloud
            : WeatherCondition.lightCloud;
        break;
      case 'Mist':
        condition = WeatherCondition.mist;
        break;
      case 'fog':
        condition = WeatherCondition.fog;
        break;
      case 'Smoke':
      case 'Haze':
      case 'Dust':
      case 'Sand':
      case 'Ash':
      case 'Squall':
      case 'Tornado':
        condition = WeatherCondition.atmosphere;
        break;
      default:
        condition = WeatherCondition.unknown;
    }

    return condition;
  }

  convertToDate(int dt) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
    String formattedDate = DateFormat("yyyy-MM-dd").format(dateTime);
    return formattedDate;
  }

  convertToWEEKDAY(int dt) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
    String formattedDate = DateFormat(DateFormat.ABBR_WEEKDAY).format(dateTime);
    return formattedDate;
  }

  getDailyWeather(List<ListElement> weatherList) {
    List<ListElement> dailyWeatherList = List.empty(growable: true);
    List<String> dateList = List.empty(growable: true);

    for (ListElement data in weatherList) {
      var date = convertToDate(data.dt!);
      bool isToday = date == DateFormat("yyyy-MM-dd").format(DateTime.now());
      if (!dateList.contains(date) && !isToday) {
        dateList.add(date);
        dailyWeatherList.add(data);
      }
    }
    return dailyWeatherList;
  }
}

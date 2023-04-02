// To parse this JSON data, do
//
//     final responseWeather = responseWeatherFromJson(jsonString);

import 'dart:convert';

ResponseWeather responseWeatherFromJson(String str) => ResponseWeather.fromJson(json.decode(str));

String responseWeatherToJson(ResponseWeather data) => json.encode(data.toJson());

class ResponseWeather {

  ResponseWeather({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });

  final String? cod;
  final int? message;
  final int? cnt;
  final List<ListElement>? list;
  final City? city;

  factory ResponseWeather.fromJson(Map<String, dynamic> json) => ResponseWeather(
    cod: json["cod"],
    message: json["message"],
    cnt: json["cnt"],
    list: json["list"] == null ? [] : List<ListElement>.from(json["list"]!.map((x) => ListElement.fromJson(x))),
    city: json["city"] == null ? null : City.fromJson(json["city"]),
  );

  Map<String, dynamic> toJson() => {
    "cod": cod,
    "message": message,
    "cnt": cnt,
    "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
    "city": city?.toJson(),
  };
}

class City {
  City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  final int? id;
  final String? name;
  final Coord? coord;
  final String? country;
  final int? population;
  final int? timezone;
  final int? sunrise;
  final int? sunset;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    coord: json["coord"] == null ? null : Coord.fromJson(json["coord"]),
    country: json["country"],
    population: json["population"],
    timezone: json["timezone"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "coord": coord?.toJson(),
    "country": country,
    "population": population,
    "timezone": timezone,
    "sunrise": sunrise,
    "sunset": sunset,
  };
}

class Coord {
  Coord({
    this.lat,
    this.lon,
  });

  final double? lat;
  final double? lon;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lon": lon,
  };
}

class ListElement {
  ListElement({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.rain,
    this.sys,
    this.dtTxt,
  });

  final int? dt;
  final Main? main;
  final List<Weather>? weather;
  final Clouds? clouds;
  final Wind? wind;
  final int? visibility;
  final double? pop;
  final Rain? rain;
  final Sys? sys;
  final DateTime? dtTxt;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    dt: json["dt"],
    main: json["main"] == null ? null : Main.fromJson(json["main"]),
    weather: json["weather"] == null ? [] : List<Weather>.from(json["weather"]!.map((x) => Weather.fromJson(x))),
    clouds: json["clouds"] == null ? null : Clouds.fromJson(json["clouds"]),
    wind: json["wind"] == null ? null : Wind.fromJson(json["wind"]),
    visibility: json["visibility"],
    pop: json["pop"]?.toDouble(),
    rain: json["rain"] == null ? null : Rain.fromJson(json["rain"]),
    sys: json["sys"] == null ? null : Sys.fromJson(json["sys"]),
    dtTxt: json["dt_txt"] == null ? null : DateTime.parse(json["dt_txt"]),
  );

  Map<String, dynamic> toJson() => {
    "dt": dt,
    "main": main?.toJson(),
    "weather": weather == null ? [] : List<dynamic>.from(weather!.map((x) => x.toJson())),
    "clouds": clouds?.toJson(),
    "wind": wind?.toJson(),
    "visibility": visibility,
    "pop": pop,
    "rain": rain?.toJson(),
    "sys": sys?.toJson(),
    "dt_txt": dtTxt?.toIso8601String(),
  };
}

class Clouds {
  Clouds({
    this.all,
  });

  final int? all;

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
    all: json["all"],
  );

  Map<String, dynamic> toJson() => {
    "all": all,
  };
}

class Main {
  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? seaLevel;
  final int? grndLevel;
  final int? humidity;
  final double? tempKf;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
    temp: json["temp"]?.toDouble(),
    feelsLike: json["feels_like"]?.toDouble(),
    tempMin: json["temp_min"]?.toDouble(),
    tempMax: json["temp_max"]?.toDouble(),
    pressure: json["pressure"],
    seaLevel: json["sea_level"],
    grndLevel: json["grnd_level"],
    humidity: json["humidity"],
    tempKf: json["temp_kf"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "temp": temp,
    "feels_like": feelsLike,
    "temp_min": tempMin,
    "temp_max": tempMax,
    "pressure": pressure,
    "sea_level": seaLevel,
    "grnd_level": grndLevel,
    "humidity": humidity,
    "temp_kf": tempKf,
  };
}

class Rain {
  Rain({
    this.the3H,
  });

  final double? the3H;

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
    the3H: json["3h"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "3h": the3H,
  };
}

class Sys {
  Sys({
    this.pod,
  });

  final String? pod;

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
    pod: json["pod"],
  );

  Map<String, dynamic> toJson() => {
    "pod": pod,
  };
}

class Weather {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json["id"],
    main: json["main"],
    description: json["description"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main": main,
    "description": description,
    "icon": icon,
  };
}

class Wind {
  Wind({
    this.speed,
    this.deg,
    this.gust,
  });

  final double? speed;
  final int? deg;
  final double? gust;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    speed: json["speed"]?.toDouble(),
    deg: json["deg"],
    gust: json["gust"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "speed": speed,
    "deg": deg,
    "gust": gust,
  };
}


// // To parse this JSON data, do
// //
// //     final responseWeather = responseWeatherFromJson(jsonString);
//
// import 'package:meta/meta.dart';
// import 'dart:convert';
//
// ResponseWeather responseWeatherFromJson(String str) => ResponseWeather.fromJson(json.decode(str));
//
// String responseWeatherToJson(ResponseWeather data) => json.encode(data.toJson());
//
// class ResponseWeather {
//   ResponseWeather({
//     required this.cod,
//     required this.message,
//     required this.cnt,
//     required this.list,
//     required this.city,
//   });
//
//   final String cod;
//   final int message;
//   final int cnt;
//   final List<ListElement> list;
//   final City city;
//
//   factory ResponseWeather.fromJson(Map<String, dynamic> json) => ResponseWeather(
//     cod: json["cod"],
//     message: json["message"],
//     cnt: json["cnt"],
//     list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
//     city: City.fromJson(json["city"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "cod": cod,
//     "message": message,
//     "cnt": cnt,
//     "list": List<dynamic>.from(list.map((x) => x.toJson())),
//     "city": city.toJson(),
//   };
// }
//
// class City {
//   City({
//     required this.id,
//     required this.name,
//     required this.coord,
//     required this.country,
//     required this.population,
//     required this.timezone,
//     required this.sunrise,
//     required this.sunset,
//   });
//
//   final int id;
//   final String name;
//   final Coord coord;
//   final String country;
//   final int population;
//   final int timezone;
//   final int sunrise;
//   final int sunset;
//
//   factory City.fromJson(Map<String, dynamic> json) => City(
//     id: json["id"],
//     name: json["name"],
//     coord: Coord.fromJson(json["coord"]),
//     country: json["country"],
//     population: json["population"],
//     timezone: json["timezone"],
//     sunrise: json["sunrise"],
//     sunset: json["sunset"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "coord": coord.toJson(),
//     "country": country,
//     "population": population,
//     "timezone": timezone,
//     "sunrise": sunrise,
//     "sunset": sunset,
//   };
// }
//
// class Coord {
//   Coord({
//     required this.lat,
//     required this.lon,
//   });
//
//   final double lat;
//   final double lon;
//
//   factory Coord.fromJson(Map<String, dynamic> json) => Coord(
//     lat: json["lat"].toDouble(),
//     lon: json["lon"].toDouble(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "lat": lat,
//     "lon": lon,
//   };
// }
//
// class ListElement {
//   ListElement({
//     required this.dt,
//     required this.main,
//     required this.weather,
//     required this.clouds,
//     required this.wind,
//     required this.visibility,
//     required this.pop,
//     required this.rain,
//     required this.sys,
//     required this.dtTxt,
//   });
//
//   final int dt;
//   final Main main;
//   final List<Weather> weather;
//   final Clouds clouds;
//   final Wind wind;
//   final int visibility;
//   final double pop;
//   final Rain rain;
//   final Sys sys;
//   final DateTime dtTxt;
//
//   factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
//     dt: json["dt"],
//     main: Main.fromJson(json["main"]),
//     weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
//     clouds: Clouds.fromJson(json["clouds"]),
//     wind: Wind.fromJson(json["wind"]),
//     visibility: json["visibility"],
//     pop: json["pop"].toDouble(),
//     rain: Rain.fromJson(json["rain"]),
//     sys: Sys.fromJson(json["sys"]),
//     dtTxt: DateTime.parse(json["dt_txt"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "dt": dt,
//     "main": main.toJson(),
//     "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
//     "clouds": clouds.toJson(),
//     "wind": wind.toJson(),
//     "visibility": visibility,
//     "pop": pop,
//     "rain": rain.toJson(),
//     "sys": sys.toJson(),
//     "dt_txt": dtTxt.toIso8601String(),
//   };
// }
//
// class Clouds {
//   Clouds({
//     required this.all,
//   });
//
//   final int all;
//
//   factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
//     all: json["all"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "all": all,
//   };
// }
//
// class Main {
//   Main({
//     required this.temp,
//     required this.feelsLike,
//     required this.tempMin,
//     required this.tempMax,
//     required this.pressure,
//     required this.seaLevel,
//     required this.grndLevel,
//     required this.humidity,
//     required this.tempKf,
//   });
//
//   final double temp;
//   final double feelsLike;
//   final double tempMin;
//   final double tempMax;
//   final int pressure;
//   final int seaLevel;
//   final int grndLevel;
//   final int humidity;
//   final double tempKf;
//
//   factory Main.fromJson(Map<String, dynamic> json) => Main(
//     temp: json["temp"].toDouble(),
//     feelsLike: json["feels_like"].toDouble(),
//     tempMin: json["temp_min"].toDouble(),
//     tempMax: json["temp_max"].toDouble(),
//     pressure: json["pressure"],
//     seaLevel: json["sea_level"],
//     grndLevel: json["grnd_level"],
//     humidity: json["humidity"],
//     tempKf: json["temp_kf"].toDouble(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "temp": temp,
//     "feels_like": feelsLike,
//     "temp_min": tempMin,
//     "temp_max": tempMax,
//     "pressure": pressure,
//     "sea_level": seaLevel,
//     "grnd_level": grndLevel,
//     "humidity": humidity,
//     "temp_kf": tempKf,
//   };
// }
//
// class Rain {
//   Rain({
//     required this.the3H,
//   });
//
//   final double the3H;
//
//   factory Rain.fromJson(Map<String, dynamic> json) => Rain(
//     the3H: json["3h"].toDouble(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "3h": the3H,
//   };
// }
//
// class Sys {
//   Sys({
//     required this.pod,
//   });
//
//   final String pod;
//
//   factory Sys.fromJson(Map<String, dynamic> json) => Sys(
//     pod: json["pod"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "pod": pod,
//   };
// }
//
// class Weather {
//   Weather({
//     required this.id,
//     required this.main,
//     required this.description,
//     required this.icon,
//   });
//
//   final int id;
//   final String main;
//   final String description;
//   final String icon;
//
//   factory Weather.fromJson(Map<String, dynamic> json) => Weather(
//     id: json["id"],
//     main: json["main"],
//     description: json["description"],
//     icon: json["icon"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "main": main,
//     "description": description,
//     "icon": icon,
//   };
// }
//
// class Wind {
//   Wind({
//     required this.speed,
//     required this.deg,
//     required this.gust,
//   });
//
//   final double speed;
//   final int deg;
//   final double gust;
//
//   factory Wind.fromJson(Map<String, dynamic> json) => Wind(
//     speed: json["speed"].toDouble(),
//     deg: json["deg"],
//     gust: json["gust"].toDouble(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "speed": speed,
//     "deg": deg,
//     "gust": gust,
//   };
// }

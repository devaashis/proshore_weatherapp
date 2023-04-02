// To parse this JSON data, do
//
//     final responseLocations = responseLocationsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ResponseLocations> responseLocationsFromJson(String str) => List<ResponseLocations>.from(json.decode(str).map((x) => ResponseLocations.fromJson(x)));

String responseLocationsToJson(List<ResponseLocations> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResponseLocations {
  ResponseLocations({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
  });

  final String name;
  final double lat;
  final double lon;
  final String? country;
  final String? state;

  factory ResponseLocations.fromJson(Map<String, dynamic> json) => ResponseLocations(
    name: json["name"],
    lat: json["lat"].toDouble(),
    lon: json["lon"].toDouble(),
    country: json["country"],
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "lat": lat,
    "lon": lon,
    "country": country,
    "state": state,
  };
}

import 'package:meta/meta.dart';
import 'dart:convert';

class CovidDataModel {
  final Map<String, int> cases;
  final Map<String, int> deaths;
  final Map<String, int> recovered;

  CovidDataModel({
    required this.cases,
    required this.deaths,
    required this.recovered,
  });

  factory CovidDataModel.fromRawJson(String str) => CovidDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CovidDataModel.fromJson(Map<String, dynamic> json) => CovidDataModel(
    cases: Map.from(json["cases"]).map((k, v) => MapEntry<String, int>(k, v)),
    deaths: Map.from(json["deaths"]).map((k, v) => MapEntry<String, int>(k, v)),
    recovered: Map.from(json["recovered"]).map((k, v) => MapEntry<String, int>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "cases": Map.from(cases).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "deaths": Map.from(deaths).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "recovered": Map.from(recovered).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

// Entities i get by parsing from json
// I've decided to not divide them by each files cause it's not too huge
@JsonSerializable(explicitToJson: true)
class Weather {
  final Current current;

  Weather({required this.current});

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Current {
  final String? time;
  @JsonKey(name: 'temp_c')
  final int temp;
  final Condition condition;
  @JsonKey(name: 'wind_kph')
  final int wind;
  @JsonKey(name: 'pressure_mb')
  final int pressure;
  @JsonKey(name: 'humidity')
  final int humidity;
  @JsonKey(name: 'feelslike_c')
  final int feelsLike;

  Current({
    required this.time,
    required this.temp,
    required this.condition,
    required this.wind,
    required this.pressure,
    required this.humidity,
    required this.feelsLike,
  });

  factory Current.fromJson(Map<String, dynamic> json) =>
      _$CurrentFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentToJson(this);
}

@JsonSerializable()
class Condition {
  final String text;

  Condition({required this.text});

  factory Condition.fromJson(Map<String, dynamic> json) =>
      _$ConditionFromJson(json);
  Map<String, dynamic> toJson() => _$ConditionToJson(this);
}

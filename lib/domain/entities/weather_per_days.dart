import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/domain/entities/weather.dart';

part 'weather_per_days.g.dart';

// Entities i get by parsing from json
// I've decided to not divide them by each files cause it's not too huge
@JsonSerializable(explicitToJson: true)
class WeatherPerDays {
  final Forecast forecast;

  WeatherPerDays({required this.forecast});

  factory WeatherPerDays.fromJson(Map<String, dynamic> json) =>
      _$WeatherPerDaysFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherPerDaysToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Forecast {
  @JsonKey(name: 'forecastday')
  final List<ForecastDay> forecastDay;

  Forecast({required this.forecastDay});

  factory Forecast.fromJson(Map<String, dynamic> json) =>
      _$ForecastFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ForecastDay {
  final List<Current> hour;

  ForecastDay({required this.hour});

  factory ForecastDay.fromJson(Map<String, dynamic> json) =>
      _$ForecastDayFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastDayToJson(this);
}

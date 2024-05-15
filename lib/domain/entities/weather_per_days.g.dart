// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_per_days.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherPerDays _$WeatherPerDaysFromJson(Map<String, dynamic> json) =>
    WeatherPerDays(
      forecast: Forecast.fromJson(json['forecast'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherPerDaysToJson(WeatherPerDays instance) =>
    <String, dynamic>{
      'forecast': instance.forecast.toJson(),
    };

Forecast _$ForecastFromJson(Map<String, dynamic> json) => Forecast(
      forecastDay: (json['forecastday'] as List<dynamic>)
          .map((e) => ForecastDay.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ForecastToJson(Forecast instance) => <String, dynamic>{
      'forecastday': instance.forecastDay.map((e) => e.toJson()).toList(),
    };

ForecastDay _$ForecastDayFromJson(Map<String, dynamic> json) => ForecastDay(
      hour: (json['hour'] as List<dynamic>)
          .map((e) => Current.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ForecastDayToJson(ForecastDay instance) =>
    <String, dynamic>{
      'hour': instance.hour.map((e) => e.toJson()).toList(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      current: Current.fromJson(json['current'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'current': instance.current.toJson(),
    };

Current _$CurrentFromJson(Map<String, dynamic> json) => Current(
      time: json['time'] as String?,
      temp: (json['temp_c'] as num).toInt(),
      condition: Condition.fromJson(json['condition'] as Map<String, dynamic>),
      wind: (json['wind_kph'] as num).toInt(),
      pressure: (json['pressure_mb'] as num).toInt(),
      humidity: (json['humidity'] as num).toInt(),
      feelsLike: (json['feelslike_c'] as num).toInt(),
    );

Map<String, dynamic> _$CurrentToJson(Current instance) => <String, dynamic>{
      'time': instance.time,
      'temp_c': instance.temp,
      'condition': instance.condition.toJson(),
      'wind_kph': instance.wind,
      'pressure_mb': instance.pressure,
      'humidity': instance.humidity,
      'feelslike_c': instance.feelsLike,
    };

Condition _$ConditionFromJson(Map<String, dynamic> json) => Condition(
      text: json['text'] as String,
    );

Map<String, dynamic> _$ConditionToJson(Condition instance) => <String, dynamic>{
      'text': instance.text,
    };

part of 'weather_bloc.dart';

// Two events for load current and per last three days weather
sealed class WeatherEvent extends Equatable {}

class LoadCurrentWeather extends WeatherEvent {
  @override
  List<Object?> get props => [];
}

class LoadWeatherPerDays extends WeatherEvent {
  @override
  List<Object?> get props => [];
}

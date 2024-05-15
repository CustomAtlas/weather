part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {}

class WeatherInitial extends WeatherState {
  @override
  List<Object?> get props => [];
}

// State for check weather loading to not push buttons many times
// and not to load same data many times at one time
class WeatherLoading extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherCurrentLoaded extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherPerDaysLoaded extends WeatherState {
  @override
  List<Object?> get props => [];
}

// State for get exception and show it in ui
class WeatherLoadingFailure extends WeatherState {
  WeatherLoadingFailure({
    required this.exception,
  });

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}

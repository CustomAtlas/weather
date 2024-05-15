import 'dart:io';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/domain/api_client/http_client.dart';
import 'package:weather_app/domain/entities/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this.client) : super(WeatherInitial()) {
    on<WeatherEvent>(
      (event, emit) async {
        switch (event) {
          case LoadCurrentWeather():
            await _loadCurrentWeather(event, emit);
          case LoadWeatherPerDays():
            await _loadWeatherPerDays(event, emit);
        }
      },
      // Sequential concurrency to not load the same data at one time
      transformer: sequential(),
    );
  }

  final MyHttpClient client;
  // Fields to use in ui
  final searchController = TextEditingController();
  String city = '';
  String? errorText;
  String errorCenter = '';
  Current? weather;
  List<Current>? weathers;

  // Loading weather for the current day:
  // Initially checking for the empty text field
  // Take city name from the TextField and save it in a variable
  // Try to get current weather by the city name
  // Try to check internet connection without packages, just by timeout
  // And getting/throwing error if something went wrong
  Future<void> _loadCurrentWeather(
    LoadCurrentWeather event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    errorCenter = '';
    if (searchController.text.trim().isEmpty &&
        state is! WeatherLoadingFailure) {
      errorText = 'Search field is empty';
      emit(WeatherLoadingFailure(exception: ''));
      return;
    }
    errorText = null;
    city = searchController.text;
    try {
      weather = await client
          .getCurrentWeather(city)
          .timeout(const Duration(seconds: 5), onTimeout: () {
        errorCenter = 'Ошибка получения данных';
        throw const SocketException('');
      });
      emit(WeatherCurrentLoaded());
    } catch (e) {
      errorCenter = 'Ошибка получения данных';
      if (e.toString() ==
          "type 'Null' is not a subtype of type 'Map<String, dynamic>' in type cast") {
        emit(WeatherLoadingFailure(
            exception: 'There is no city with this name'));
      } else {
        emit(WeatherLoadingFailure(exception: e.toString()));
      }
    }
  }

  // Loading weather for the current day:
  // Initially checking for the empty text field
  // Take city name from the variable above
  // Try to get weather within three last days by the city name
  // Try to check internet connection without packages, just by timeout
  // And getting/throwing error if something went wrong
  Future<void> _loadWeatherPerDays(
    LoadWeatherPerDays event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    try {
      weathers = await client
          .getWeatherPerDays(city)
          .timeout(const Duration(seconds: 8), onTimeout: () {
        throw const SocketException('');
      });
      emit(WeatherPerDaysLoaded());
    } catch (e) {
      emit(WeatherLoadingFailure(exception: 'Ошибка получения данных'));
    }
  }
}

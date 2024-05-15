import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/api_client/http_client.dart';
import 'package:weather_app/screens/search.dart';
import 'package:weather_app/screens/weather_days.dart';
import 'package:weather_app/screens/weather_details.dart';
import 'package:weather_app/weather_bloc/weather_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // HttpClient for the bloc
    // Provider to provide data of bloc into ui
    final client = MyHttpClient();
    return BlocProvider(
      create: (context) => WeatherBloc(client),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          Screens.search: (_) => const SearchScreen(),
          Screens.weatherDetails: (_) => const WeatherDetailsScreen(),
          Screens.weatherDays: (_) => const WeatherDaysScreen(),
        },
        initialRoute: Screens.search,
      ),
    );
  }
}

// Comfortable route names and avoiding mistakes
// in strings each time of using navigator
abstract class Screens {
  static const search = '/';
  static const weatherDetails = '/weatherDetails';
  static const weatherDays = '/weatherDetails/weatherDays';
}

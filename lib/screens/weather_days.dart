import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/screens/image.dart';
import 'package:weather_app/screens/weather_details.dart';
import 'package:weather_app/weather_bloc/weather_bloc.dart';

class WeatherDaysScreen extends StatelessWidget {
  const WeatherDaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WeatherBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather within 3 last days in ${bloc.city}',
          style: const TextStyle(fontSize: 18),
        ),
        titleTextStyle: const TextStyle(fontSize: 20, color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: const DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(image: AppImages.weather, fit: BoxFit.cover),
        ),
        child: _WeatherListWidget(),
      ),
    );
  }
}

class _WeatherListWidget extends StatelessWidget {
  const _WeatherListWidget();

  @override
  Widget build(BuildContext context) {
    final weathers = context.read<WeatherBloc>().weathers;
    return Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, i) => DetailsWeatherWidget(
            time: weathers![i].time ?? '',
            condition: weathers[i].condition.text,
            temp: weathers[i].temp,
            feelsLike: weathers[i].feelsLike,
            wind: weathers[i].wind,
            humidity: weathers[i].humidity,
            pressure: weathers[i].pressure,
          ),
        ));
  }
}

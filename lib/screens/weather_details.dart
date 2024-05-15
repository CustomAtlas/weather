import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/screens/image.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/weather_bloc/weather_bloc.dart';

class WeatherDetailsScreen extends StatelessWidget {
  const WeatherDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WeatherBloc>();
    final weather = bloc.weather;
    return Scaffold(
        appBar: AppBar(
          title: Text('Weather in the ${bloc.city}'),
          titleTextStyle: const TextStyle(fontSize: 20, color: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.cyan,
          actions: const [_DaysIconButtonWidget()],
        ),
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AppImages.weather, fit: BoxFit.cover),
          ),
          child: DetailsWeatherWidget(
            // In api response of current day weather there is no time field
            // so i make it by myself
            time:
                '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
            condition: weather!.condition.text,
            temp: weather.temp,
            feelsLike: weather.feelsLike,
            wind: weather.wind,
            humidity: weather.humidity,
            pressure: weather.pressure,
          ),
        ));
  }
}

class _DaysIconButtonWidget extends StatelessWidget {
  const _DaysIconButtonWidget();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WeatherBloc>();
    // BlocListener here to listen state changes and
    // either open new screen or show error
    return BlocListener<WeatherBloc, WeatherState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is WeatherPerDaysLoaded) {
          Navigator.of(context).pushNamed(Screens.weatherDays);
        } else if (state is WeatherLoadingFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.symmetric(
                vertical: 300,
                horizontal: 100,
              ),
              content: Text(state.exception.toString()),
              duration: const Duration(milliseconds: 1500),
            ),
          );
        }
      },
      child: IconButton(
        // Check weather loading to not push buttons many times
        // and not to load same data many times at one time
        onPressed: () => bloc.state is WeatherLoading
            ? null
            : bloc.add(LoadWeatherPerDays()),
        icon: const Icon(Icons.device_thermostat_outlined),
      ),
    );
  }
}

// Reusable widget
class DetailsWeatherWidget extends StatelessWidget {
  const DetailsWeatherWidget({
    super.key,
    required this.time,
    required this.condition,
    required this.temp,
    required this.feelsLike,
    required this.wind,
    required this.humidity,
    required this.pressure,
  });

  final String time;
  final String condition;
  final int temp;
  final int feelsLike;
  final int wind;
  final int humidity;
  final int pressure;

  @override
  Widget build(BuildContext context) {
    // Reusable text style
    const style = TextStyle(color: Colors.white, fontSize: 20);
    return Align(
      alignment: const Alignment(-0.7, -0.8),
      child: Card(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(time, style: style),
              Text(condition, style: style),
              Text('$temp *C', style: style),
              Text('Feels like: $feelsLike *C', style: style),
              Text('Wind: $wind kph', style: style),
              Text('Humidity: $humidity %', style: style),
              // Convert mbar from api to usual mmHg
              Text('Pressure: ${pressure * 0.75} mmHg', style: style),
            ],
          ),
        ),
      ),
    );
  }
}

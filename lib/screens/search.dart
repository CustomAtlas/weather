import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/screens/image.dart';
import 'package:weather_app/weather_bloc/weather_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search weather for city'),
        titleTextStyle: const TextStyle(fontSize: 20, color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: const DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AppImages.weather,
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Here and further divide widgets to do code more understanble
              _TextFieldWidget(),
              SizedBox(height: 20),
              _SearchButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextFieldWidget extends StatelessWidget {
  const _TextFieldWidget();

  @override
  Widget build(BuildContext context) {
    // Bloc by provider to show errors and take text from TextField
    // Here context.WATCH to show errors
    final bloc = context.watch<WeatherBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          bloc.errorCenter,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: BoxConstraints(
            // Try to show TextField more adaptive for different screens and devices
            maxWidth: MediaQuery.of(context).size.width > 500 ? 400 : 300,
          ),
          child: TextField(
            controller: bloc.searchController,
            decoration: InputDecoration(
              errorText: bloc.errorText,
              hintText: 'Enter city name',
              hintStyle: const TextStyle(color: Colors.black),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchButtonWidget extends StatelessWidget {
  const _SearchButtonWidget();

  @override
  Widget build(BuildContext context) {
    // Here and further context.READ because widgets just take data
    // and there is no need to rebuild it in the same screen
    // BlocListener here to listen state changes and
    // either open new screen or show error
    final bloc = context.read<WeatherBloc>();
    return BlocListener<WeatherBloc, WeatherState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is WeatherCurrentLoaded) {
          Navigator.of(context).pushNamed(Screens.weatherDetails);
          // Don't show SnackBar when error is just empty TextField
        } else if (state is WeatherLoadingFailure && state.exception != '') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              // Try to show SnackBar at center of screen by listening keyboard visibility
              margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(Scaffold.of(context).context)
                            .viewInsets
                            .bottom >
                        0
                    ? 100
                    : 300,
                horizontal: 100,
              ),
              content: Text(state.exception.toString()),
              duration: const Duration(milliseconds: 1500),
            ),
          );
        }
      },
      child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.cyan)),
          // Check weather loading to not push buttons many times
          // and not to load same data many times at one time
          onPressed: () => bloc.state is WeatherLoading
              ? null
              : bloc.add(LoadCurrentWeather()),
          child: const Text(
            'Search',
            style: TextStyle(color: Colors.black),
          )),
    );
  }
}

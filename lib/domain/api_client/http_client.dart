import 'dart:convert';
import 'dart:io';

import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/entities/weather_per_days.dart';

class MyHttpClient {
  final client = HttpClient();
  // ApiKey i've get after auth on weather api site
  final apiKey = '0a9b0506e94c439baa9135215241405';

  //  Here i get weather by city name within three last days by algorithm
  // where current day subtracts by index
  //  In choosen days i take weather at 13 o'clock and add it in list of weathers
  //  Before return list of weathers, i sort it by temperature from lower to higher
  Future<List<Current>> getWeatherPerDays(String city) async {
    List<Current> currents = [];
    for (int i = 1; i < 4; i++) {
      final json = await _get(
              'http://api.weatherapi.com/v1/history.json?key=$apiKey&q=$city&dt=${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day - i}')
          as Map<String, dynamic>;
      final a = WeatherPerDays.fromJson(json).forecast.forecastDay[0].hour[13];
      currents.add(a);
    }
    currents.sort((a, b) => a.temp.compareTo(b.temp));
    return currents;
  }

  // Here i just get current weather by city name
  Future<Current> getCurrentWeather(String city) async {
    final json = await _get(
            'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city&aqi=no')
        as Map<String, dynamic>;
    return Weather.fromJson(json).current;
  }

  // Helper function to get json from api
  Future<dynamic> _get(String uri) async {
    final url = Uri.parse(uri);
    final request = await client.getUrl(url);
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final dynamic json = jsonDecode(jsonString);
    return json;
  }
}

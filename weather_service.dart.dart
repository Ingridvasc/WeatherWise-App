import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/models/weather_model.dart';

class WeatherService extends ChangeNotifier {
  Weather? _currentWeather;
  bool _isLoading = false;

  Weather? get currentWeather => _currentWeather;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=SUA_CHAVE_API&units=metric&lang=pt'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _currentWeather = Weather(
          city: data['name'],
          temperature: data['main']['temp'],
          condition: data['weather'][0]['description'],
          icon: data['weather'][0]['icon'],
          lastUpdated: DateTime.now(),
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateLocalPhoto(String path) {
    if (_currentWeather != null) {
      _currentWeather = _currentWeather!.copyWith(localPhotoPath: path);
      notifyListeners();
    }
  }
}
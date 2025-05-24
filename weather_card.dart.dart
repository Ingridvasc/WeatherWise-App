import 'package:flutter/material.dart';
import 'package:weather_app/data/models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  final VoidCallback onPhotoTap;

  const WeatherCard({
    super.key,
    required this.weather,
    required this.onPhotoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              weather.city,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            subtitle: Text(
              'Atualizado: ${weather.lastUpdated.hour}:${weather.lastUpdated.minute}',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${weather.temperature.toStringAsFixed(1)}°C',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(width: 10),
                    Image.network(
                      'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                      width: 60,
                    ),
                  ],
                ),
                Text(
                  weather.condition,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          if (weather.localPhotoPath != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.file(
                File(weather.localPhotoPath!),
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          TextButton(
            onPressed: onPhotoTap,
            child: const Text('Adicionar foto local'),
          ),
        ],
      ),
    );
  }
}
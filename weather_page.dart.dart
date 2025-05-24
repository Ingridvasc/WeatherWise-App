import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/services/weather_service.dart';
import 'package:weather_app/presentation/widgets/weather_card.dart';
import 'package:image_picker/image_picker.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherService>(context, listen: false)
          .fetchWeather('São Paulo');
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherService = Provider.of<WeatherService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Now'),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: _takePhoto,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Cidade',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => weatherService.fetchWeather(_cityController.text),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (weatherService.isLoading)
              const CircularProgressIndicator()
            else if (weatherService.currentWeather != null)
              Expanded(
                child: WeatherCard(
                  weather: weatherService.currentWeather!,
                  onPhotoTap: _takePhoto,
                ),
              )
            else
              const Text('Nenhum dado disponível'),
          ],
        ),
      ),
    );
  }

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    
    if (image != null) {
      Provider.of<WeatherService>(context, listen: false)
          .updateLocalPhoto(image.path);
    }
  }
}
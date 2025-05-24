class Weather {
  final String city;
  final double temperature;
  final String condition;
  final String icon;
  final DateTime lastUpdated;
  final String? localPhotoPath;

  Weather({
    required this.city,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.lastUpdated,
    this.localPhotoPath,
  });
}
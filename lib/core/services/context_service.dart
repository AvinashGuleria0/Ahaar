import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/sync_service.dart'; // To access dioProvider
import 'notification_service.dart';

final contextServiceProvider = Provider<ContextService>((ref) {
  final dio = ref.watch(dioProvider);
  final notificationService = ref.watch(notificationServiceProvider);
  return ContextService(dio: dio, notificationService: notificationService);
});

class ContextService {
  final Dio dio;
  final NotificationService notificationService;

  ContextService({required this.dio, required this.notificationService});

  Future<bool> _requestPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the 
      // App to enable the location services.
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again.
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return false;
    }

    return true;
  }

  /// Fetches the local weather using Open-Meteo API based on current GPS location.
  /// Returns a record with temperature (Celsius) and weatherCode, or null if denied/failed.
  Future<({double temperature, int weatherCode})?> fetchLocalWeather() async {
    try {
      final hasPermission = await _requestPermission();
      if (!hasPermission) {
        return null; // Graceful fallback if permission denied
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low, // low accuracy is sufficient for weather
      );

      final response = await dio.get(
        'https://api.open-meteo.com/v1/forecast',
        queryParameters: {
          'latitude': position.latitude,
          'longitude': position.longitude,
          'current_weather': 'true',
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['current_weather'] != null) {
          final temp = (data['current_weather']['temperature'] as num).toDouble();
          final code = (data['current_weather']['weathercode'] as num).toInt();
          
          // Trigger the coaching alert if temperature > 35
          if (temp > 35) {
            notificationService.triggerWeatherAlert(temp);
          }
          
          return (temperature: temp, weatherCode: code);
        }
      }
    } catch (e) {
      print('ContextService Error: Failed to fetch local weather: $e');
    }
    return null;
  }
}

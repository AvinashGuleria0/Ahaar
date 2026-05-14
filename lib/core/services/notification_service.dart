import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:io' show Platform;

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _hasFiredWeatherAlertToday = false;

  Future<void> init() async {
    // 1. Initialize timezones strictly required for scheduled notifications
    tz.initializeTimeZones();

    // 2. Set native icons (Android requires mipmap icon)
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    
    // iOS settings (Darwin)
    final darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final initSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
    );

    await _plugin.initialize(initSettings);

    // 3. Android 13+ Post Notifications Explicit Request
    if (Platform.isAndroid) {
      await _plugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
          
      // Exact alarms permission request for Android 12+
      await _plugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.requestExactAlarmsPermission();
    }
  }

  /// Triggers an immediate push notification for extreme heat.
  /// Locks state to ensure it only fires once per app session to avoid spam.
  Future<void> triggerWeatherAlert(double temp) async {
    if (_hasFiredWeatherAlertToday) return;

    const androidDetails = AndroidNotificationDetails(
      'weather_channel',
      'Weather Alerts',
      channelDescription: 'Important hydration alerts based on local heat.',
      importance: Importance.max,
      priority: Priority.high,
    );
    
    const darwinDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
    );

    await _plugin.show(
      0, // Notification ID
      '☀️ Extreme Heat Warning',
      'It\'s scorching outside (${temp.toStringAsFixed(1)}°C)! Keep a water bottle handy today. 💧',
      notificationDetails,
    );

    _hasFiredWeatherAlertToday = true;
  }

  /// Schedules a 5:00 PM gym reminder natively on the OS alarm queue.
  Future<void> scheduleGymReminder(String dayName) async {
    final now = DateTime.now();
    // Calculate 5:00 PM (17:00) today
    final scheduledDate = DateTime(now.year, now.month, now.day, 17, 0, 0);

    // Strict chronological safeguard: Do not schedule for the past.
    if (scheduledDate.isBefore(now)) {
      print('NotificationService: 5:00 PM has already passed. Gym reminder aborted for today.');
      return;
    }

    const androidDetails = AndroidNotificationDetails(
      'gym_channel',
      'Gym Reminders',
      channelDescription: 'Daily coaching reminders to hit the gym.',
      importance: Importance.high,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await _plugin.zonedSchedule(
      1, // Notification ID
      '🏋️ Workout Time!',
      'Time to crush your $dayName workout! 💪',
      tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
    
    print('NotificationService: Scheduled gym reminder for ${tz.TZDateTime.from(scheduledDate, tz.local)}');
  }
}

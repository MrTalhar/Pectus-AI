import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    tz.initializeTimeZones();
    // No longer trying to set local timezone as it can be tricky on some devices
    // We will use tz.local for current time but check it later

    const androidSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    const initSettings = InitializationSettings(android: androidSettings);

    await _notifications.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle tap
      },
    );

    // Create the channel explicitly for Android
    if (Platform.isAndroid) {
      final androidPlugin = _notifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      if (androidPlugin != null) {
        await androidPlugin.createNotificationChannel(const AndroidNotificationChannel(
          'pectus_reminders',
          'Exercise Reminders',
          description: 'Daily reminders for your pectus exercises',
          importance: Importance.high,
          playSound: true,
          enableVibration: true,
        ));
      }
    }

    _initialized = true;
  }

  Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      // For Android 13+, use permission_handler for better reliability
      final status = await Permission.notification.request();
      if (status.isGranted) return true;
      
      // Fallback to plugin's built-in request
      final android = _notifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      if (android != null) {
        final granted = await android.requestNotificationsPermission();
        return granted ?? false;
      }
    }
    return true;
  }

  Future<void> scheduleDailyReminder({
    required int hour,
    required int minute,
  }) async {
    await _notifications.cancelAll();

    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    const androidDetails = AndroidNotificationDetails(
      'pectus_reminders',
      'Exercise Reminders',
      channelDescription: 'Daily reminders for your pectus exercises',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/launcher_icon',
      enableVibration: true,
      playSound: true,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await _notifications.zonedSchedule(
      id: 0,
      title: 'Time for Your Exercises! 💪',
      body: 'Consistency is key! Take a few minutes to do your exercises today.',
      scheduledDate: scheduledDate,
      notificationDetails: notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('reminder_enabled', true);
    await prefs.setInt('reminder_hour', hour);
    await prefs.setInt('reminder_minute', minute);
  }

  Future<void> cancelAllReminders() async {
    await _notifications.cancelAll();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('reminder_enabled', false);
  }

  Future<bool> isReminderEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('reminder_enabled') ?? false;
  }

  Future<int> getReminderHour() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('reminder_hour') ?? 9;
  }

  Future<int> getReminderMinute() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('reminder_minute') ?? 0;
  }

  Future<void> sendTestNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'pectus_reminders',
      'Exercise Reminders',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/launcher_icon',
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await _notifications.show(
      id: 99,
      title: 'Reminders Active! ✅',
      body: 'You\'ll receive a notification daily at your set time.',
      notificationDetails: notificationDetails,
    );
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _checkAndResetExpiredStreak();
  }

  int get completedSessions => _prefs?.getInt('completed_sessions') ?? 0;
  
  Future<void> incrementCompletedSessions() async {
    final current = completedSessions;
    await _prefs?.setInt('completed_sessions', current + 1);
  }

  int get streakDays => _prefs?.getInt('streak_days') ?? 0;

  /// Helper to get a date with time stripped out (midnight) for calendar calculations
  DateTime _toCalendarDate(DateTime dt) {
    return DateTime(dt.year, dt.month, dt.day);
  }

  /// Checks on app start if the streak is broken and resets it to 0 if so.
  /// A streak is broken if the last workout date was before yesterday.
  void _checkAndResetExpiredStreak() {
    final lastWorkoutTimeStr = _prefs?.getString('last_workout_time');
    if (lastWorkoutTimeStr != null) {
      final lastWorkout = DateTime.parse(lastWorkoutTimeStr);
      final lastWorkoutDate = _toCalendarDate(lastWorkout);
      final todayDate = _toCalendarDate(DateTime.now());
      
      final daysDiff = todayDate.difference(lastWorkoutDate).inDays;
      if (daysDiff > 1) {
        // Last workout was before yesterday, so the streak is broken
        _prefs?.setInt('streak_days', 0);
      }
    }
  }

  Future<void> updateStreak() async {
    final lastWorkoutTimeStr = _prefs?.getString('last_workout_time');
    final now = DateTime.now();
    final todayDate = _toCalendarDate(now);
    
    if (lastWorkoutTimeStr != null) {
      final lastWorkout = DateTime.parse(lastWorkoutTimeStr);
      final lastWorkoutDate = _toCalendarDate(lastWorkout);
      final daysDiff = todayDate.difference(lastWorkoutDate).inDays;
      
      if (daysDiff == 1) {
        // Consecutive day - increment streak
        await _prefs?.setInt('streak_days', streakDays + 1);
      } else if (daysDiff > 1) {
        // Missed a day - reset streak to 1
        await _prefs?.setInt('streak_days', 1);
      }
      // If daysDiff == 0 (already worked out today), do not increment again
    } else {
      // First workout ever
      await _prefs?.setInt('streak_days', 1);
    }
    
    await _prefs?.setString('last_workout_time', now.toIso8601String());
  }

  // Difficulty level
  String get difficultyLevel => _prefs?.getString('difficulty_level') ?? 'Medium';

  Future<void> setDifficultyLevel(String level) async {
    await _prefs?.setString('difficulty_level', level);
  }

  // Profile image path
  String? get profileImagePath => _prefs?.getString('profile_image_path');

  Future<void> setProfileImagePath(String path) async {
    await _prefs?.setString('profile_image_path', path);
  }

  // User name
  String get userName => _prefs?.getString('user_name') ?? 'Talha Riaz';

  Future<void> setUserName(String name) async {
    await _prefs?.setString('user_name', name);
  }

  // Auth & Onboarding
  bool get isLoggedIn => _prefs?.getBool('is_logged_in') ?? false;
  Future<void> setLoggedIn(bool value) async {
    await _prefs?.setBool('is_logged_in', value);
  }

  bool get hasCompletedOnboarding => _prefs?.getBool('has_completed_onboarding') ?? false;
  Future<void> setHasCompletedOnboarding(bool value) async {
    await _prefs?.setBool('has_completed_onboarding', value);
  }

  double get pectusDepth => _prefs?.getDouble('pectus_depth') ?? 0.0;
  Future<void> setPectusDepth(double value) async {
    await _prefs?.setDouble('pectus_depth', value);
  }

  String get pectusSeverity => _prefs?.getString('pectus_severity') ?? 'Low';
  Future<void> setPectusSeverity(String value) async {
    await _prefs?.setString('pectus_severity', value);
  }

  // Theme settings
  bool get isDarkMode => _prefs?.getBool('is_dark_mode') ?? true; // Default to true (dark)
  Future<void> setDarkMode(bool value) async {
    await _prefs?.setBool('is_dark_mode', value);
  }

  // ── Per-exercise completion tracking ─────────────────────────────────────

  /// Returns how many times a specific exercise has been completed.
  int getExerciseCompletionCount(String exerciseId) {
    return _prefs?.getInt('ex_count_$exerciseId') ?? 0;
  }

  /// Increments the completion counter for a specific exercise.
  Future<void> incrementExerciseCompletion(String exerciseId) async {
    final current = getExerciseCompletionCount(exerciseId);
    await _prefs?.setInt('ex_count_$exerciseId', current + 1);
    // Keep a registry of all tracked exercise IDs for history reads.
    final tracked = _prefs?.getStringList('tracked_exercise_ids') ?? [];
    if (!tracked.contains(exerciseId)) {
      tracked.add(exerciseId);
      await _prefs?.setStringList('tracked_exercise_ids', tracked);
    }
  }

  /// Returns a map of exerciseId → completion count for all tracked exercises.
  Map<String, int> getExerciseHistory() {
    final tracked = _prefs?.getStringList('tracked_exercise_ids') ?? [];
    final Map<String, int> history = {};
    for (final id in tracked) {
      history[id] = getExerciseCompletionCount(id);
    }
    return history;
  }
}


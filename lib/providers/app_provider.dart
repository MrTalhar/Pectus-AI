import 'package:flutter/foundation.dart';
import '../services/storage_service.dart';

class AppProvider with ChangeNotifier {
  final StorageService _storageService = StorageService();

  int get completedSessions => _storageService.completedSessions;
  int get streakDays => _storageService.streakDays;
  String get difficultyLevel => _storageService.difficultyLevel;
  String? get profileImagePath => _storageService.profileImagePath;
  String get userName => _storageService.userName;

  Future<void> init() async {
    await _storageService.init();
    notifyListeners();
  }

  Future<void> logSessionCompletion() async {
    await _storageService.incrementCompletedSessions();
    await _storageService.updateStreak();
    notifyListeners();
  }

  Future<void> setDifficultyLevel(String level) async {
    await _storageService.setDifficultyLevel(level);
    notifyListeners();
  }

  Future<void> setProfileImagePath(String path) async {
    await _storageService.setProfileImagePath(path);
    notifyListeners();
  }

  Future<void> setUserName(String name) async {
    await _storageService.setUserName(name);
    notifyListeners();
  }

  // Auth & Onboarding
  bool get isLoggedIn => _storageService.isLoggedIn;
  Future<void> setLoggedIn(bool value) async {
    await _storageService.setLoggedIn(value);
    notifyListeners();
  }

  bool get hasCompletedOnboarding => _storageService.hasCompletedOnboarding;
  Future<void> setHasCompletedOnboarding(bool value) async {
    await _storageService.setHasCompletedOnboarding(value);
    notifyListeners();
  }

  double get pectusDepth => _storageService.pectusDepth;
  Future<void> setPectusDepth(double value) async {
    await _storageService.setPectusDepth(value);
    notifyListeners();
  }

  String get pectusSeverity => _storageService.pectusSeverity;
  Future<void> setPectusSeverity(String value) async {
    await _storageService.setPectusSeverity(value);
    notifyListeners();
  }

  // Theme settings
  bool get isDarkMode => _storageService.isDarkMode;
  Future<void> toggleTheme() async {
    await _storageService.setDarkMode(!isDarkMode);
    notifyListeners();
  }

  // ── Per-exercise tracking ──────────────────────────────────────────────

  /// Returns how many times a specific exercise has been completed.
  int getExerciseCount(String exerciseId) =>
      _storageService.getExerciseCompletionCount(exerciseId);

  /// Returns the full exercise history (exerciseId → count).
  Map<String, int> get exerciseHistory => _storageService.getExerciseHistory();

  /// Logs both the general session and the specific exercise completion.
  Future<void> logExerciseCompletion(String exerciseId) async {
    await _storageService.incrementExerciseCompletion(exerciseId);
    await _storageService.incrementCompletedSessions();
    await _storageService.updateStreak();
    notifyListeners();
  }
}


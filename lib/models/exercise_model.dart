class Exercise {
  final String id;
  final String title;
  final String description;
  final String instructions;
  final String benefits;
  final int durationSeconds;
  final ExerciseCategory category;
  final ExerciseDifficulty difficulty;
  /// Optional animated GIF URL demonstrating this exercise
  final String? gifUrl;

  static const String _gifBase =
      'https://raw.githubusercontent.com/hasaneyldrm/exercises-dataset/main/';

  Exercise({
    required this.id,
    required this.title,
    required this.description,
    required this.instructions,
    required this.benefits,
    required this.durationSeconds,
    required this.category,
    this.difficulty = ExerciseDifficulty.medium,
    String? gifFile,
  }) : gifUrl = gifFile != null ? '$_gifBase$gifFile' : null;
}

enum ExerciseCategory {
  breathing,
  posture,
  strength,
  flexibility,
  cardio,
}

enum ExerciseDifficulty {
  easy,
  medium,
  hard,
}

extension CategoryExtension on ExerciseCategory {
  String get displayName {
    switch (this) {
      case ExerciseCategory.breathing:
        return 'Breathing';
      case ExerciseCategory.posture:
        return 'Posture';
      case ExerciseCategory.strength:
        return 'Strength';
      case ExerciseCategory.flexibility:
        return 'Flexibility';
      case ExerciseCategory.cardio:
        return 'Cardio';
    }
  }
}

extension DifficultyExtension on ExerciseDifficulty {
  String get displayName {
    switch (this) {
      case ExerciseDifficulty.easy:
        return 'Easy';
      case ExerciseDifficulty.medium:
        return 'Medium';
      case ExerciseDifficulty.hard:
        return 'Hard';
    }
  }

  /// Returns a colour hex string for UI badges
  int get colorValue {
    switch (this) {
      case ExerciseDifficulty.easy:
        return 0xFF4ADE80; // green
      case ExerciseDifficulty.medium:
        return 0xFFFBBF24; // amber
      case ExerciseDifficulty.hard:
        return 0xFFF87171; // red
    }
  }
}

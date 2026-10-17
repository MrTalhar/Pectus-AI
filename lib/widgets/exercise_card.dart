import 'package:flutter/material.dart';
import '../models/exercise_model.dart';
import '../screens/exercise_detail_screen.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;

  const ExerciseCard({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExerciseDetailScreen(exercise: exercise),
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // Circular icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor.withAlpha(20),
                ),
                child: Icon(
                  _getCategoryIcon(exercise.category),
                  size: 26,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(width: 14),
              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exercise.category.displayName,
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 14,
                          color: Theme.of(context).textTheme.labelLarge?.color,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${exercise.durationSeconds ~/ 60} min',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).textTheme.labelLarge?.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).textTheme.labelLarge?.color,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(ExerciseCategory category) {
    switch (category) {
      case ExerciseCategory.breathing:
        return Icons.air;
      case ExerciseCategory.posture:
        return Icons.accessibility_new;
      case ExerciseCategory.strength:
        return Icons.fitness_center;
      case ExerciseCategory.flexibility:
        return Icons.self_improvement;
      case ExerciseCategory.cardio:
        return Icons.directions_run;
    }
  }
}

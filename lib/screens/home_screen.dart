import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/stat_card.dart';
import 'session_mode_screen.dart';
import '../models/exercise_model.dart';
import '../data/dummy_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /// Picks the best suggested exercise based on the user's difficulty level.
  Exercise _suggestedExercise(String level) {
    ExerciseDifficulty target;
    switch (level) {
      case 'Easy':
        target = ExerciseDifficulty.easy;
        break;
      case 'Hard':
        target = ExerciseDifficulty.hard;
        break;
      default:
        target = ExerciseDifficulty.medium;
    }
    return dummyExercises.firstWhere(
      (e) => e.difficulty == target,
      orElse: () => dummyExercises.first,
    );
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Text(
                'Good Morning,',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.labelLarge?.color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                provider.userName,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 24),
              // Stats row
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      title: 'Current Streak',
                      value: '${provider.streakDays} Days',
                      icon: Icons.local_fire_department,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: StatCard(
                      title: 'Sessions',
                      value: '${provider.completedSessions}',
                      icon: Icons.check_circle_outline,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Progress Summary Card (replaces AI card)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withAlpha(180),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Keep Going! 💪',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              provider.completedSessions == 0
                                  ? 'Start your first session today and build a healthy habit.'
                                  : 'You\'ve completed ${provider.completedSessions} session${provider.completedSessions == 1 ? '' : 's'}. Stay consistent!',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimary
                                    .withAlpha(200),
                                fontSize: 14,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withAlpha(30),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.trending_up_rounded,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Today's Suggested Workout Card
              Builder(builder: (context) {
                final suggested = _suggestedExercise(provider.difficultyLevel);
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).primaryColor.withAlpha(20),
                              ),
                              child: Icon(
                                Icons.timer,
                                color: Theme.of(context).primaryColor,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Today's Suggested Workout",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Theme.of(context).textTheme.labelLarge?.color,
                                    ),
                                  ),
                                  Text(
                                    suggested.title,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).textTheme.bodyLarge?.color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Difficulty badge
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Color(suggested.difficulty.colorValue).withAlpha(20),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                suggested.difficulty.displayName,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Color(suggested.difficulty.colorValue),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          suggested.description,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.labelLarge?.color,
                            fontSize: 13,
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SessionModeScreen(
                                    exercise: suggested,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.play_arrow, size: 20),
                            label: const Text(
                              'Start Workout',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Theme.of(context).colorScheme.onPrimary,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 24),
              // Motivational tip
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 4),
                    Icon(
                      Icons.lightbulb_outline,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Even 5 minutes daily can make a difference over time.',
                        style: TextStyle(
                          fontSize: 13,
                          color:
                              Theme.of(context).textTheme.labelLarge?.color,
                          height: 1.3,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

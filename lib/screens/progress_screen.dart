import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/stat_card.dart';
import '../models/exercise_model.dart';
import '../data/dummy_data.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final exerciseHistory = provider.exerciseHistory;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Progress',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Overview stats ──────────────────────────────────────────
            Text(
              'Overview',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Total Sessions',
                    value: '${provider.completedSessions}',
                    icon: Icons.fitness_center,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: StatCard(
                    title: 'Current Streak',
                    value: '${provider.streakDays} days',
                    icon: Icons.local_fire_department,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Exercises Tried',
                    value: '${exerciseHistory.length}',
                    icon: Icons.checklist_rounded,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: StatCard(
                    title: 'Total Exercises',
                    value: '${dummyExercises.length}',
                    icon: Icons.library_books_rounded,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // ── Exercise history ────────────────────────────────────────
            Text(
              'Exercise History',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Track how many times you\'ve done each exercise.',
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).textTheme.labelLarge?.color,
              ),
            ),
            const SizedBox(height: 16),
            ...dummyExercises.map((exercise) {
              final count = exerciseHistory[exercise.id] ?? 0;
              const goal = 10; // completions to "master" an exercise
              final progress = (count / goal).clamp(0.0, 1.0);
              final isMastered = count >= goal;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isMastered
                        ? const Color(0xFF4ADE80).withAlpha(60)
                        : Theme.of(context).dividerColor.withAlpha(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Category pill
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .primaryColor
                                .withAlpha(20),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            exercise.category.displayName.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        const Spacer(),
                        // Mastered badge
                        if (isMastered)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4ADE80).withAlpha(20),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.star,
                                    size: 12, color: Color(0xFF4ADE80)),
                                SizedBox(width: 4),
                                Text(
                                  'Mastered',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF4ADE80),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            exercise.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                          ),
                        ),
                        Text(
                          count == 0
                              ? 'Not started'
                              : '$count / $goal',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: count == 0
                                ? Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.color
                                    ?.withAlpha(100)
                                : isMastered
                                    ? const Color(0xFF4ADE80)
                                    : Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 6,
                        backgroundColor:
                            Theme.of(context).primaryColor.withAlpha(15),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isMastered
                              ? const Color(0xFF4ADE80)
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    if (count > 0 && !isMastered)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          '${goal - count} more to master',
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.color
                                ?.withAlpha(120),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 28),

            // ── Achievements ────────────────────────────────────────────
            Text(
              'Achievements',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 14),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.05,
              children: [
                _buildBadgeCard(
                  context,
                  'First Step',
                  'Complete 1 session',
                  Icons.star,
                  provider.completedSessions >= 1,
                ),
                _buildBadgeCard(
                  context,
                  'Consistency',
                  '3 day streak',
                  Icons.trending_up,
                  provider.streakDays >= 3,
                ),
                _buildBadgeCard(
                  context,
                  'Dedication',
                  '10 total sessions',
                  Icons.emoji_events,
                  provider.completedSessions >= 10,
                ),
                _buildBadgeCard(
                  context,
                  'Iron Will',
                  '7 day streak',
                  Icons.diamond,
                  provider.streakDays >= 7,
                ),
                _buildBadgeCard(
                  context,
                  'Explorer',
                  'Try 5 exercises',
                  Icons.explore,
                  exerciseHistory.length >= 5,
                ),
                _buildBadgeCard(
                  context,
                  'Completionist',
                  'Try all exercises',
                  Icons.library_add_check,
                  exerciseHistory.length >= dummyExercises.length,
                ),
                _buildBadgeCard(
                  context,
                  'Master',
                  'Master any exercise',
                  Icons.military_tech,
                  exerciseHistory.values.any((c) => c >= 10),
                ),
                _buildBadgeCard(
                  context,
                  'Legend',
                  '30 total sessions',
                  Icons.local_fire_department,
                  provider.completedSessions >= 30,
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildBadgeCard(BuildContext context, String title, String subtitle,
      IconData icon, bool isUnlocked) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isUnlocked
              ? const Color(0xFFFCD34D).withAlpha(60)
              : Theme.of(context).dividerColor.withAlpha(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isUnlocked
                  ? const Color(0xFFFCD34D).withAlpha(20)
                  : Theme.of(context).primaryColor.withAlpha(10),
            ),
            child: Icon(
              icon,
              size: 24,
              color: isUnlocked
                  ? const Color(0xFFFCD34D)
                  : Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.color
                      ?.withAlpha(80),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: isUnlocked
                  ? Theme.of(context).textTheme.bodyLarge?.color
                  : Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.color
                      ?.withAlpha(80),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: isUnlocked
                  ? Theme.of(context).textTheme.labelLarge?.color
                  : Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.color
                      ?.withAlpha(40),
            ),
          ),
        ],
      ),
    );
  }
}

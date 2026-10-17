import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../data/dummy_data.dart';
import '../models/exercise_model.dart';
import '../widgets/exercise_card.dart';

class ExerciseLibraryScreen extends StatefulWidget {
  const ExerciseLibraryScreen({super.key});

  @override
  State<ExerciseLibraryScreen> createState() => _ExerciseLibraryScreenState();
}

class _ExerciseLibraryScreenState extends State<ExerciseLibraryScreen> {
  ExerciseCategory? _selectedCategory;

  /// Returns which difficulty levels to show based on the user's chosen level.
  /// Easy → only Easy.  Medium → Easy + Medium.  Hard → all.
  List<ExerciseDifficulty> _allowedDifficulties(String level) {
    switch (level) {
      case 'Easy':
        return [ExerciseDifficulty.easy];
      case 'Medium':
        return [ExerciseDifficulty.easy, ExerciseDifficulty.medium];
      case 'Hard':
      default:
        return ExerciseDifficulty.values;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final allowed = _allowedDifficulties(provider.difficultyLevel);

    // First filter by difficulty, then by category
    final filteredExercises = dummyExercises
        .where((e) => allowed.contains(e.difficulty))
        .where((e) => _selectedCategory == null || e.category == _selectedCategory)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exercise Library',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        automaticallyImplyLeading: false,
        actions: [
          // Difficulty level badge in the app bar
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () => _showDifficultyInfo(context, provider),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _difficultyColor(provider.difficultyLevel).withAlpha(25),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: _difficultyColor(provider.difficultyLevel).withAlpha(80),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.tune_rounded,
                      size: 14,
                      color: _difficultyColor(provider.difficultyLevel),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      provider.difficultyLevel,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _difficultyColor(provider.difficultyLevel),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Difficulty info banner
          _buildDifficultyBanner(context, provider, filteredExercises.length),

          // Category filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Row(
              children: [
                _buildFilterChip('All', null),
                const SizedBox(width: 8),
                ...ExerciseCategory.values.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: _buildFilterChip(category.displayName, category),
                  );
                }),
              ],
            ),
          ),

          // Exercise count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Row(
              children: [
                Text(
                  '${filteredExercises.length} exercise${filteredExercises.length == 1 ? '' : 's'}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).textTheme.labelLarge?.color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: filteredExercises.isEmpty
                ? _buildEmptyState(context, provider)
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    itemCount: filteredExercises.length,
                    itemBuilder: (context, index) {
                      return ExerciseCard(exercise: filteredExercises[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyBanner(
      BuildContext context, AppProvider provider, int count) {
    final level = provider.difficultyLevel;
    final color = _difficultyColor(level);
    final description = _difficultyDescription(level);

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withAlpha(40)),
      ),
      child: Row(
        children: [
          Icon(_difficultyIcon(level), color: color, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () => _showDifficultyInfo(context, provider),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Change',
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppProvider provider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.fitness_center_outlined,
              size: 60,
              color: Theme.of(context).textTheme.labelLarge?.color?.withAlpha(80),
            ),
            const SizedBox(height: 16),
            Text(
              'No exercises in this category\nfor ${provider.difficultyLevel} level.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).textTheme.labelLarge?.color,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => setState(() => _selectedCategory = null),
              child: const Text('Show All Categories'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, ExerciseCategory? category) {
    final isSelected = _selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Theme.of(context).dividerColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).textTheme.labelLarge?.color,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Color _difficultyColor(String level) {
    switch (level) {
      case 'Easy':
        return const Color(0xFF4ADE80);
      case 'Medium':
        return const Color(0xFFFBBF24);
      case 'Hard':
        return const Color(0xFFF87171);
      default:
        return const Color(0xFFFBBF24);
    }
  }

  IconData _difficultyIcon(String level) {
    switch (level) {
      case 'Easy':
        return Icons.sentiment_satisfied_alt_rounded;
      case 'Medium':
        return Icons.sentiment_neutral_rounded;
      case 'Hard':
        return Icons.local_fire_department_rounded;
      default:
        return Icons.tune_rounded;
    }
  }

  String _difficultyDescription(String level) {
    switch (level) {
      case 'Easy':
        return 'Showing Easy exercises only. Great for beginners.';
      case 'Medium':
        return 'Showing Easy + Medium exercises. Building up intensity.';
      case 'Hard':
        return 'Showing all exercises including Hard. Push your limits!';
      default:
        return 'Filtered by your difficulty level.';
    }
  }

  void _showDifficultyInfo(BuildContext context, AppProvider provider) {
    final levels = ['Easy', 'Medium', 'Hard'];
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardTheme.color,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).textTheme.labelLarge?.color?.withAlpha(60),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Select Your Level',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'This filters which exercises appear in the library.',
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).textTheme.labelLarge?.color,
              ),
            ),
            const SizedBox(height: 20),
            ...levels.map((level) {
              final isSelected = provider.difficultyLevel == level;
              final color = _difficultyColor(level);
              return GestureDetector(
                onTap: () async {
                  await provider.setDifficultyLevel(level);
                  if (ctx.mounted) Navigator.pop(ctx);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? color.withAlpha(20) : Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? color : Theme.of(context).dividerColor,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(_difficultyIcon(level), color: color, size: 22),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              level,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: isSelected ? color : Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                            Text(
                              _difficultyDescription(level),
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).textTheme.labelLarge?.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(Icons.check_circle, color: color, size: 20),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

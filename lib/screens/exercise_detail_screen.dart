import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/exercise_model.dart';
import '../widgets/custom_button.dart';
import 'session_mode_screen.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final Exercise exercise;

  const ExerciseDetailScreen({super.key, required this.exercise});

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  File? _localGifFile;
  bool _isLoadingLocal = true;

  @override
  void initState() {
    super.initState();
    _checkLocalGif();
  }

  /// Checks if the GIF has been downloaded locally
  Future<void> _checkLocalGif() async {
    if (widget.exercise.gifUrl == null) {
      setState(() {
        _isLoadingLocal = false;
      });
      return;
    }

    try {
      final directory = await getApplicationDocumentsDirectory();
      // Extract the filename from the URL (e.g. 1316-cA9FuWG.gif)
      final fileName = widget.exercise.gifUrl!.split('/').last;
      final file = File('${directory.path}/gifs/$fileName');

      if (await file.exists()) {
        setState(() {
          _localGifFile = file;
        });
      }
    } catch (_) {
      // Fallback silently to network
    } finally {
      setState(() {
        _isLoadingLocal = false;
      });
    }
  }

  /// Opens a YouTube search for this exercise in the YouTube app (or browser).
  Future<void> _openYouTube(BuildContext context) async {
    final query = Uri.encodeComponent(
      '${widget.exercise.title} exercise how to tutorial',
    );
    final youtubeAppUri = Uri.parse('youtube://www.youtube.com/results?search_query=$query');
    final youtubeWebUri = Uri.parse('https://www.youtube.com/results?search_query=$query');

    try {
      if (await canLaunchUrl(youtubeAppUri)) {
        await launchUrl(youtubeAppUri);
      } else {
        await launchUrl(youtubeWebUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Could not open YouTube. Please check your internet connection.'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                ),
                child: widget.exercise.gifUrl != null
                    ? _GifHero(
                        gifUrl: widget.exercise.gifUrl!,
                        localFile: _localGifFile,
                        isLoadingLocal: _isLoadingLocal,
                        difficulty: widget.exercise.difficulty,
                      )
                    : _IconHero(
                        category: widget.exercise.category,
                        difficulty: widget.exercise.difficulty,
                      ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Theme.of(context).primaryColor.withAlpha(40),
                      ),
                    ),
                    child: Text(
                      widget.exercise.category.displayName.toUpperCase(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    widget.exercise.title,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Duration pill
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardTheme.color,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              color: Theme.of(context).textTheme.labelLarge?.color,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${widget.exercise.durationSeconds ~/ 60} min',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).textTheme.labelLarge?.color,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildSection(context, 'Description', widget.exercise.description),
                  const SizedBox(height: 20),
                  _buildSection(context, 'Instructions', widget.exercise.instructions),
                  const SizedBox(height: 20),
                  _buildSection(context, 'Benefits', widget.exercise.benefits),
                  const SizedBox(height: 140), // Increased to avoid bottom sheet overlap
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border(
            top: BorderSide(
                color: Theme.of(context).dividerColor, width: 0.5),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'Start Session',
                icon: Icons.play_arrow,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SessionModeScreen(exercise: widget.exercise),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            // Style matches Start Session exactly but in Red
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'Watch on YouTube',
                icon: Icons.play_circle_filled_rounded,
                backgroundColor: const Color(0xFFFF0000),
                foregroundColor: Colors.white,
                onPressed: () => _openYouTube(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
      BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).textTheme.labelLarge?.color,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Hero widget: animated GIF (supports local file & network fallback)
// ─────────────────────────────────────────────────────────────
class _GifHero extends StatelessWidget {
  final String gifUrl;
  final File? localFile;
  final bool isLoadingLocal;
  final ExerciseDifficulty difficulty;

  const _GifHero({
    required this.gifUrl,
    required this.localFile,
    required this.isLoadingLocal,
    required this.difficulty,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Show local GIF if available, otherwise fetch from network
        if (isLoadingLocal)
          Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          )
        else if (localFile != null)
          Image.file(
            localFile!,
            fit: BoxFit.contain,
          )
        else
          Image.network(
            gifUrl,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                  color: Theme.of(context).primaryColor,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => _IconHero(
              category: ExerciseCategory.strength,
              difficulty: difficulty,
            ),
          ),
        // Subtle gradient overlay at bottom
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Theme.of(context).scaffoldBackgroundColor.withAlpha(200),
                ],
              ),
            ),
          ),
        ),
        // Difficulty badge
        Positioned(
          bottom: 12,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: Color(difficulty.colorValue).withAlpha(220),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              difficulty.displayName,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        // GIF label
        Positioned(
          bottom: 12,
          left: 16,
          child: Row(
            children: [
              Icon(
                localFile != null ? Icons.offline_pin_rounded : Icons.play_circle_outline_rounded,
                size: 16,
                color: localFile != null ? Colors.greenAccent : Colors.white70,
              ),
              const SizedBox(width: 4),
              Text(
                localFile != null ? 'Offline HD' : 'Live Demo',
                style: TextStyle(
                  fontSize: 12,
                  color: localFile != null ? Colors.greenAccent : Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Hero widget: category icon fallback (no GIF available)
// ─────────────────────────────────────────────────────────────
class _IconHero extends StatelessWidget {
  final ExerciseCategory category;
  final ExerciseDifficulty difficulty;

  const _IconHero({required this.category, required this.difficulty});

  IconData _icon() {
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor.withAlpha(20),
            ),
            child: Icon(
              _icon(),
              size: 44,
              color: Theme.of(context).primaryColor.withAlpha(150),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: Color(difficulty.colorValue).withAlpha(20),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: Color(difficulty.colorValue).withAlpha(60),
              ),
            ),
            child: Text(
              difficulty.displayName,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(difficulty.colorValue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

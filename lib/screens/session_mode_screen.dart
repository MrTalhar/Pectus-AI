import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/exercise_model.dart';
import '../providers/app_provider.dart';

class SessionModeScreen extends StatefulWidget {
  final Exercise exercise;

  const SessionModeScreen({super.key, required this.exercise});

  @override
  State<SessionModeScreen> createState() => _SessionModeScreenState();
}

class _SessionModeScreenState extends State<SessionModeScreen> {
  late int _remainingSeconds;
  Timer? _timer;
  bool _isRunning = false;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.exercise.durationSeconds;
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
        _completeSession();
      }
    });
  }

  void _pauseTimer() {
    setState(() {
      _isRunning = false;
    });
    _timer?.cancel();
  }

  void _completeSession() async {
    setState(() {
      _isRunning = false;
      _isCompleted = true;
    });
    // Log this specific exercise + general session counter
    await Provider.of<AppProvider>(context, listen: false)
        .logExerciseCompletion(widget.exercise.id);
  }

  void _skipExercise() {
    _timer?.cancel();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _timeString {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    double progress = 1 - (_remainingSeconds / widget.exercise.durationSeconds);

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 56), // Account for custom header space
                    // Exercise title
                    Text(
                      widget.exercise.title,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Theme.of(context).primaryColor.withAlpha(20),
                        border: Border.all(
                          color: Theme.of(context).primaryColor.withAlpha(40),
                        ),
                      ),
                      child: Text(
                        widget.exercise.category.displayName.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    const Spacer(flex: 2),
                    // Timer ring
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 240,
                          height: 240,
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 8,
                            strokeCap: StrokeCap.round,
                            backgroundColor: Theme.of(context).cardTheme.color,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _isCompleted
                                  ? const Color(0xFF4ADE80)
                                  : Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _isCompleted ? '✓' : _timeString,
                              style: TextStyle(
                                fontSize: _isCompleted ? 52 : 48,
                                fontWeight: FontWeight.bold,
                                color: _isCompleted
                                    ? const Color(0xFF4ADE80)
                                    : Theme.of(context).textTheme.bodyLarge?.color,
                                fontFeatures: const [FontFeature.tabularFigures()],
                              ),
                            ),
                            if (_isCompleted)
                              const Text(
                                'Complete!',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF4ADE80),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(flex: 2),
                    // Controls
                    if (!_isCompleted) ...[
                      // Play / Pause — circular
                      GestureDetector(
                        onTap: _isRunning ? _pauseTimer : _startTimer,
                        child: Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Icon(
                            _isRunning ? Icons.pause : Icons.play_arrow,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 36,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Skip button — pill
                      TextButton(
                        onPressed: _skipExercise,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.skip_next,
                              size: 18,
                              color: Theme.of(context).textTheme.labelLarge?.color,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Skip Exercise',
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).textTheme.labelLarge?.color,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4ADE80),
                            foregroundColor: const Color(0xFF0D0D0F),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Finish Workout',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    const Spacer(flex: 1),
                    // Swipe indicator
                    if (!_isCompleted)
                      Column(
                        children: [
                          Icon(Icons.keyboard_arrow_up_rounded, color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(100)),
                          Text(
                            'Swipe up for instructions',
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(100),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
          // Custom Header
          Positioned(
            top: 0, left: 0, right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.close, color: Theme.of(context).textTheme.bodyLarge?.color),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      'Session',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Theme.of(context).textTheme.bodyLarge?.color),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Swipe up sheet
          if (!_isCompleted)
            DraggableScrollableSheet(
              initialChildSize: 0.1,
              minChildSize: 0.05,
              maxChildSize: 0.8,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color?.withAlpha(240),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor.withAlpha(100),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(24),
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(60),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'How to do: ${widget.exercise.title}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildInstructionSection('Method', widget.exercise.instructions),
                      const SizedBox(height: 20),
                      _buildInstructionSection('Benefits', widget.exercise.benefits),
                      const SizedBox(height: 40),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildInstructionSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).primaryColor,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(200),
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

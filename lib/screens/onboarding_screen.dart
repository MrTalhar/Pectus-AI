import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'main_navigation_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  double _pectusDepth = 2.5;

  String get _severityLevel {
    if (_pectusDepth <= 3.0) return 'Low';
    if (_pectusDepth <= 5.0) return 'Mild';
    return 'High';
  }

  Color get _severityColor {
    if (_pectusDepth <= 3.0) return Colors.greenAccent;
    if (_pectusDepth <= 5.0) return Colors.orangeAccent;
    return Colors.redAccent;
  }

  Future<void> _completeOnboarding() async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    
    await provider.setPectusDepth(_pectusDepth);
    await provider.setPectusSeverity(_severityLevel);
    await provider.setHasCompletedOnboarding(true);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0F),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Let\'s Personalize Your Plan',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'To give you the best exercises, we need to know the approximate depth of your Pectus Excavatum.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withAlpha(180),
                  height: 1.5,
                ),
              ),
              const Spacer(),
              
              // Measurement Display
              Container(
                padding: const EdgeInsets.symmetric(vertical: 32),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: _severityColor.withAlpha(50),
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      '${_pectusDepth.toStringAsFixed(1)} cm',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: _severityColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: _severityColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        '$_severityLevel Severity',
                        style: TextStyle(
                          color: _severityColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),

              // Slider
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('0 cm', style: TextStyle(color: Colors.white.withAlpha(100))),
                      Text('10 cm', style: TextStyle(color: Colors.white.withAlpha(100))),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: _severityColor,
                      inactiveTrackColor: Colors.white.withAlpha(20),
                      thumbColor: Colors.white,
                      overlayColor: _severityColor.withAlpha(30),
                      trackHeight: 8,
                    ),
                    child: Slider(
                      value: _pectusDepth,
                      min: 0.0,
                      max: 10.0,
                      divisions: 100,
                      onChanged: (value) {
                        setState(() {
                          _pectusDepth = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              
              const Spacer(),
              ElevatedButton(
                onPressed: _completeOnboarding,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4DD0E1),
                  foregroundColor: const Color(0xFF0D0D0F),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

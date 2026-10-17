import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../services/notification_service.dart';
import 'main_navigation_screen.dart';
// Login and onboarding screens are hidden from the app flow.
// Their files remain on disk but are not loaded at startup.

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _initializeApp();

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _fadeController.forward();
    });
  }

  Future<void> _initializeApp() async {
    try {
      // Initialize Storage
      final provider = Provider.of<AppProvider>(context, listen: false);
      await provider.init();

      // Initialize Notifications
      final notificationService = NotificationService();
      await notificationService.init();
    } catch (e) {
      debugPrint('Initialization error: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
        _navigateToHome();
      }
    }
  }

  void _navigateToHome() {
    // Always navigate directly to the main app — no login or onboarding required.
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (!mounted) return;
      if (_isInitialized) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const MainNavigationScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      } else {
        // If not ready yet, check again in 500ms
        _navigateToHome();
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).cardTheme.color ?? const Color(0xFF1A1A2E),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 3),
              // Actual App Logo
              Hero(
                tag: 'app_logo',
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withAlpha(30),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/icon/app_icon.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.air,
                        size: 60,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'PECTUS',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 10,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'EXCAVATUM',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 12,
                  color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(140),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withAlpha(40),
                  ),
                ),
                child: Text(
                  'Exercise & Posture',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const Spacer(flex: 3),
              // Inspirational Quote
              FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.format_quote,
                        size: 28,
                        color: Theme.of(context).primaryColor.withAlpha(80),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Your chest doesn\'t define your strength.\nEvery breath you take is proof of your resilience.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          height: 1.6,
                          color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(180),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 2),
              // Loading indicator
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor.withAlpha(100),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

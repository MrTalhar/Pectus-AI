import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'onboarding_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLogin = true;
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _name = '';

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      final provider = Provider.of<AppProvider>(context, listen: false);
      if (!_isLogin && _name.isNotEmpty) {
        await provider.setUserName(_name);
      }
      await provider.setLoggedIn(true);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // App Logo/Icon
                  Hero(
                    tag: 'app_logo',
                    child: Container(
                      width: 100,
                      height: 100,
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
                            size: 50,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    _isLogin ? 'Welcome Back' : 'Create Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _isLogin
                        ? 'Sign in to continue your journey'
                        : 'Start your journey to a better chest',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(150),
                    ),
                  ),
                  const SizedBox(height: 48),

                  if (!_isLogin) ...[
                    TextFormField(
                      style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                      decoration: _inputDecoration(context, 'Full Name', Icons.person_outline),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your name' : null,
                      onSaved: (value) => _name = value!,
                    ),
                    const SizedBox(height: 16),
                  ],

                  TextFormField(
                    style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                    decoration: _inputDecoration(context, 'Email', Icons.email_outlined),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        value!.isEmpty || !value.contains('@')
                            ? 'Please enter a valid email'
                            : null,
                    onSaved: (value) => _email = value!,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                    decoration: _inputDecoration(context, 'Password', Icons.lock_outline),
                    obscureText: true,
                    validator: (value) =>
                        value!.length < 6 ? 'Password must be at least 6 characters' : null,
                    onSaved: (value) => _password = value!,
                  ),
                  const SizedBox(height: 32),

                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      _isLogin ? 'Sign In' : 'Sign Up',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(
                      _isLogin
                          ? 'Don\'t have an account? Sign Up'
                          : 'Already have an account? Sign In',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(BuildContext context, String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(150)),
      prefixIcon: Icon(icon, color: Theme.of(context).primaryColor.withAlpha(150)),
      filled: true,
      fillColor: Theme.of(context).cardTheme.color,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1),
      ),
    );
  }
}

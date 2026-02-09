import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dashboard/screens/user_dashboard_screen.dart';
import '../providers/auth_provider.dart';
import '../../dashboard/screens/admin_dashboard_screen.dart';
import '../../dashboard/screens/driver_dashboard_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static Route<void> route() => MaterialPageRoute(builder: (_) => const LoginScreen());

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false; // Local loading state for the button

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final user = await ref.read(authControllerProvider.notifier).login(
            _emailController.text,
            _passwordController.text,
          );

      // --- DIRECT NAVIGATION ON SUCCESS ---
      if (mounted) {
        final destination = switch (user.role.toUpperCase()) {
          'ADMIN' || 'MANAGER' => AdminDashboardScreen.route(),
          'EMPLOYEE' => UserDashboardScreen.route(),
          'DRIVER' => DriverDashboardScreen.route(),
          _ => UserDashboardScreen.route(),
        };
        Navigator.of(context).pushAndRemoveUntil(destination, (route) => false);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _togglePasswordVisibility() {
    setState(() => _obscureText = !_obscureText);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // No longer using ref.listen for navigation, as it's handled in _submit

    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Welcome Back', style: textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text(
                    'Please sign in to your account to continue.',
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 48),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : FilledButton(
                          onPressed: _submit,
                          child: const Text('Sign In'),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

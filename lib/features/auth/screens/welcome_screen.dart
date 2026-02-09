import 'package:flutter/material.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static Route<void> route() => MaterialPageRoute(builder: (_) => const WelcomeScreen());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Image.network(
                'https://www.cmpdi.co.in/sites/default/files/cmpdi_new_logo_10012025.png',
                height: 80,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.business, size: 80, color: colorScheme.primary),
              ),
              const SizedBox(height: 24),
              Text(
                'Vehicle Booking Portal',
                textAlign: TextAlign.center,
                style: textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'CMPDI Regional Institute-4, Nagpur',
                textAlign: TextAlign.center,
                style: textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6)),
              ),
              const Spacer(flex: 2),
              FilledButton.icon(
                icon: const Icon(Icons.login),
                label: const Text('Login'),
                onPressed: () => Navigator.of(context).push(LoginScreen.route()),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                icon: const Icon(Icons.person_add_alt_1),
                label: const Text('Register'),
                onPressed: () {
                  // TODO: Navigate to Registration Screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Registration feature not yet implemented.')),
                  );
                },
              ),
              const Spacer(),
              TextButton(
                child: const Text('Admin Portal'),
                onPressed: () {
                    // TODO: Navigate to Admin Login Screen
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Admin portal not yet implemented.')),
                    );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

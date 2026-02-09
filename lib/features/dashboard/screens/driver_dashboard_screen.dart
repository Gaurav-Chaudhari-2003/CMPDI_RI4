import 'package:flutter/material.dart';

class DriverDashboardScreen extends StatelessWidget {
  const DriverDashboardScreen({super.key});

  static Route<void> route() => MaterialPageRoute(builder: (_) => const DriverDashboardScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Driver Dashboard')),
      body: const Center(
        child: Text('Welcome, Driver!'),
      ),
    );
  }
}

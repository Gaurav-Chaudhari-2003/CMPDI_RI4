import 'package:flutter/material.dart';

import '../../bookings/screens/create_booking_screen.dart';
import '../models/vehicle.dart';

class VehicleDetailScreen extends StatelessWidget {
  final Vehicle vehicle;

  const VehicleDetailScreen({super.key, required this.vehicle});

  // Route helper
  static Route<void> route(Vehicle vehicle) => 
      MaterialPageRoute(builder: (_) => VehicleDetailScreen(vehicle: vehicle));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(vehicle.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              vehicle.imageUrl,
              height: 250,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) => 
                  progress == null ? child : const Center(heightFactor: 4, child: CircularProgressIndicator()),
              errorBuilder: (context, error, stack) => 
                  const Icon(Icons.image_not_supported, size: 150, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(vehicle.name, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildDetailRow(context, Icons.person_outline, 'Capacity', '${vehicle.capacity} Seats'),
                  const Divider(height: 24),
                  _buildDetailRow(context, Icons.local_gas_station_outlined, 'Fuel Type', vehicle.fuelType),
                  // You can add more details here from your vehicle model
                  // e.g., _buildDetailRow(context, Icons.info_outline, 'Description', vehicle.description ?? 'N/A'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FilledButton(
          onPressed: () {
            Navigator.of(context).push(CreateBookingScreen.route(vehicle.id));
          },
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('Book Now', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600]),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600])),
            const SizedBox(height: 2),
            Text(value, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}
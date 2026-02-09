import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/api/api_service.dart';
import '../models/booking.dart';
import '../providers/booking_provider.dart';

class BookingCard extends ConsumerWidget {
  final Booking booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('d MMM yyyy').format(DateTime.parse(booking.fromDateTime)),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                ),
                Text(
                  booking.status,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: _getStatusColor(booking.status),
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              booking.vehicle, // Directly use the vehicle name string
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              '${booking.pickupLocation} to ${booking.dropLocation}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            // Display driver and vehicle info only for approved bookings
            if (booking.status == 'APPROVED') ...[
              const Divider(height: 24, thickness: 1),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Vehicle Image
                  if (booking.vehicleImage != null && booking.vehicleImage!.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        booking.vehicleImage!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => 
                            const Icon(Icons.image_not_supported, size: 80, color: Colors.grey),
                      ),
                    ),
                  if (booking.vehicleImage != null) const SizedBox(width: 16),
                  // Driver Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Driver Details',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        if (booking.driverName != null)
                          _buildDetailRow(context, Icons.person_outline, booking.driverName!),
                        
                        if (booking.driverContact != null && booking.driverContact!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: () async {
                              final Uri launchUri = Uri(
                                scheme: 'tel',
                                path: booking.driverContact,
                              );
                              if (await canLaunchUrl(launchUri)) {
                                await launchUrl(launchUri);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Could not make a phone call to ${booking.driverContact}')),
                                );
                              }
                            },
                            icon: const Icon(Icons.phone_outlined, size: 16),
                            label: const Text('Call Driver'),
                            style: ElevatedButton.styleFrom(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              textStyle: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            ],
            // Display cancel button only for pending bookings
            if (booking.status == 'PENDING') ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () async {
                    try {
                      await ref.read(apiServiceProvider).cancelBooking(booking.id);
                      ref.refresh(bookingListProvider); // Refresh the list
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Booking cancelled successfully')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to cancel booking: $e')),
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Cancel Booking'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade700),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'APPROVED':
        return Colors.green;
      case 'REJECTED':
      case 'CANCELLED':
        return Colors.red;
      case 'PENDING':
        return Colors.orange;
      case 'COMPLETED':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}

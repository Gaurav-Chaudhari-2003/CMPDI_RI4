import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers/booking_provider.dart';

class CreateBookingScreen extends ConsumerStatefulWidget {
  final int vehicleId;

  const CreateBookingScreen({super.key, required this.vehicleId});

  static Route<void> route(int vehicleId) => MaterialPageRoute(
        builder: (_) => CreateBookingScreen(vehicleId: vehicleId),
      );

  @override
  ConsumerState<CreateBookingScreen> createState() => _CreateBookingScreenState();
}

class _CreateBookingScreenState extends ConsumerState<CreateBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pickupController = TextEditingController();
  final _dropController = TextEditingController();
  final _purposeController = TextEditingController();

  DateTime? _fromDateTime;
  DateTime? _toDateTime;

  @override
  void dispose() {
    _pickupController.dispose();
    _dropController.dispose();
    _purposeController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime(bool isFrom) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (time == null) return;

    final dateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);

    setState(() {
      if (isFrom) {
        _fromDateTime = dateTime;
      } else {
        _toDateTime = dateTime;
      }
    });
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (_fromDateTime == null || _toDateTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select both start and end dates')),
        );
        return;
      }
      if (_toDateTime!.isBefore(_fromDateTime!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('End date cannot be before the start date')),
        );
        return;
      }

      ref.read(bookingControllerProvider.notifier).createBooking(
            vehicleId: widget.vehicleId,
            fromDateTime: _fromDateTime!,
            toDateTime: _toDateTime!,
            pickupLocation: _pickupController.text,
            dropLocation: _dropController.text,
            purpose: _purposeController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<BookingState>(bookingControllerProvider, (previous, next) {
      next.maybeWhen(
        success: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.green),
          );
          Navigator.of(context).pop(); // Go back to the detail screen
        },
        error: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error), backgroundColor: Colors.red),
          );
        },
        orElse: () {},
      );
    });

    final bookingState = ref.watch(bookingControllerProvider);
    final dateFormat = DateFormat('MMM d, yyyy - hh:mm a');

    return Scaffold(
      appBar: AppBar(title: const Text('Create Booking')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // From DateTime
              _buildDateTimePicker(
                label: 'Start Journey',
                value: _fromDateTime != null ? dateFormat.format(_fromDateTime!) : 'Select Date & Time',
                onPressed: () => _pickDateTime(true),
              ),
              const SizedBox(height: 16),
              // To DateTime
              _buildDateTimePicker(
                label: 'End Journey',
                value: _toDateTime != null ? dateFormat.format(_toDateTime!) : 'Select Date & Time',
                onPressed: () => _pickDateTime(false),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _pickupController,
                decoration: const InputDecoration(labelText: 'Pickup Location', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dropController,
                decoration: const InputDecoration(labelText: 'Drop-off Location', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _purposeController,
                decoration: const InputDecoration(labelText: 'Purpose of Booking', border: OutlineInputBorder()),
                validator: (v) => v!.isEmpty ? 'Required' : null,
                maxLines: 3,
              ),
              const SizedBox(height: 32),
              bookingState.maybeWhen(
                loading: () => const Center(child: CircularProgressIndicator()),
                orElse: () => FilledButton(
                  onPressed: _submit,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Submit Booking', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimePicker({
    required String label,
    required String value,
    required VoidCallback onPressed,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 8),
        InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value),
                const Icon(Icons.calendar_month_outlined, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
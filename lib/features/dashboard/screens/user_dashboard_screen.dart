import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../bookings/screens/my_bookings_screen.dart';
import '../../vehicles/models/vehicle.dart';
import '../../vehicles/providers/vehicle_provider.dart';
import '../../bookings/screens/booking_bottom_sheet.dart';

class UserDashboardScreen extends ConsumerStatefulWidget {
  const UserDashboardScreen({super.key});

  static Route<void> route() =>
      MaterialPageRoute(builder: (_) => const UserDashboardScreen());

  @override
  ConsumerState<UserDashboardScreen> createState() => _UserDashboardScreen();
}

class _UserDashboardScreen extends ConsumerState<UserDashboardScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isSearchPerformed = false;

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final now = DateTime.now();
    DateTime firstDate;
    DateTime initialDate;

    if (isStart) {
      firstDate = now.subtract(const Duration(days: 10));
      initialDate = _startDate ?? now;
      if(initialDate.isBefore(firstDate)) {
        initialDate = firstDate;
      }
    } else {
      firstDate = _startDate ?? now;
      initialDate = _endDate ?? firstDate;
      if (initialDate.isBefore(firstDate)) {
        initialDate = firstDate;
      }
    }

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: now.add(const Duration(days: 365)),
    );

    if (pickedDate != null && context.mounted) {
      final initialTime = TimeOfDay.fromDateTime(initialDate);
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );

      if (pickedTime != null) {
        setState(() {
          final newDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          if (isStart) {
            _startDate = newDate;
            if (_endDate != null && _endDate!.isBefore(_startDate!)) {
              _endDate = null;
            }
          } else {
            _endDate = newDate;
          }
          _isSearchPerformed = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final vehiclesAsync = ref.watch(vehicleListProvider);
    final bool canFilter = _startDate != null && _endDate != null;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/logo.png', errorBuilder: (c, o, s) => const Icon(Icons.directions_car)),
        ),
        title: const Text('Vehicle Booking'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildFilterSection(context, canFilter),
                  vehiclesAsync.when(
                    data: (vehicles) {
                      final filteredVehicles = vehicles.where((vehicle) => vehicle.isAvailable).toList();

                      if (filteredVehicles.isEmpty && _isSearchPerformed) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.directions_car_outlined,
                                    size: 64, color: Colors.grey),
                                const SizedBox(height: 16),
                                Text('No vehicles available.',
                                    style: Theme.of(context).textTheme.titleMedium),
                                Text('Try adjusting your selected dates.',
                                    style: Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 16.0),
                        itemCount: filteredVehicles.length,
                        itemBuilder: (context, index) {
                          final vehicle = filteredVehicles[index];
                          return VehicleCard(
                            vehicle: vehicle,
                            canBook: _isSearchPerformed,
                            startDate: _startDate,
                            endDate: _endDate,
                          );
                        },
                      );
                    },
                    loading: () => const Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    error: (err, stack) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Error: $err', textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent_outlined),
            label: 'Support',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.of(context).push(MyBookingsScreen.route());
          }
        },
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context, bool canFilter) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Plan Your Journey',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            _buildDateSelector(context, 'Journey Start Date', _startDate, true),
            const SizedBox(height: 12),
            _buildDateSelector(context, 'Return Date', _endDate, false),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF005540),
                ),
                onPressed: canFilter
                    ? () {
                  if (_endDate!.isBefore(_startDate!)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Return date must be after the start date.')),
                    );
                    return;
                  }
                  ref.read(vehicleFilterProvider.notifier).state =
                      VehicleFilter(
                        from: _startDate,
                        to: _endDate,
                      );
                  setState(() {
                    _isSearchPerformed = true;
                  });
                }
                    : null,
                child: const Text('Find Vehicles', style: TextStyle(fontSize: 16),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector(
      BuildContext context, String label, DateTime? date, bool isStart) {
    final format = DateFormat('MMM d, yyyy - hh:mm a');
    return InkWell(
      onTap: () => _selectDate(context, isStart),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: const Icon(Icons.calendar_today),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        ),
        child: Text(
          date != null ? format.format(date) : 'Select Date & Time',
          style: TextStyle(
            color: date != null ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }
}

class VehicleCard extends StatelessWidget {
  const VehicleCard({
    super.key,
    required this.vehicle,
    required this.canBook,
    this.startDate,
    this.endDate,
  });

  final Vehicle vehicle;
  final bool canBook;
  final DateTime? startDate;
  final DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 180,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: vehicle.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(
                      Icons.image_not_supported,
                      size: 100,
                      color: Colors.grey),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vehicle.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        vehicle.regNo,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Chip(
                      label: Text('${vehicle.capacity} Seats'),
                      backgroundColor: const Color(0xFFE0F2F1),
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: Text(vehicle.fuelType),
                      backgroundColor: const Color(0xFFE0F2F1),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: canBook
                        ? () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20)),
                        ),
                        builder: (_) => BookingBottomSheet(
                          vehicle: vehicle,
                          initialStartDate: startDate,
                          initialEndDate: endDate,
                        ),
                      );
                    }
                        : null,
                    child: const Text('Book Now', style: TextStyle(fontSize: 16)),
                  ),
                ),
                if (!canBook)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: Text(
                        'Select journey dates and find vehicles to book',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

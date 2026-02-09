import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/booking_provider.dart';
import '../widgets/booking_card.dart';

class MyBookingsScreen extends ConsumerStatefulWidget {
  const MyBookingsScreen({super.key});

  static Route<void> route() => MaterialPageRoute(builder: (_) => const MyBookingsScreen());

  @override
  ConsumerState<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends ConsumerState<MyBookingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingsAsync = ref.watch(bookingListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: bookingsAsync.when(
        data: (bookings) {
          final upcoming = bookings.where((b) => b.status == 'APPROVED' || b.status == 'PENDING').toList();
          final completed = bookings.where((b) => b.status == 'COMPLETED').toList();
          final cancelled = bookings.where((b) => b.status == 'REJECTED' || b.status == 'CANCELLED').toList();

          return TabBarView(
            controller: _tabController,
            children: [
              _BookingList(bookings: upcoming),
              _BookingList(bookings: completed),
              _BookingList(bookings: cancelled),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Error: $err', textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}

class _BookingList extends StatelessWidget {
  final List<dynamic> bookings;

  const _BookingList({required this.bookings});

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return const Center(child: Text('You have no bookings in this category.'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return BookingCard(booking: booking);
      },
    );
  }
}

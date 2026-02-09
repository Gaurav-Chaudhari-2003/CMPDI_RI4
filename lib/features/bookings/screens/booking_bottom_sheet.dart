import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_dragmarker/flutter_map_dragmarker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../../vehicles/models/vehicle.dart';
import '../providers/booking_provider.dart';

class BookingBottomSheet extends ConsumerStatefulWidget {
  const BookingBottomSheet({
    super.key,
    required this.vehicle,
    this.initialStartDate,
    this.initialEndDate,
  });

  final Vehicle vehicle;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;

  @override
  ConsumerState<BookingBottomSheet> createState() => _BookingBottomSheetState();
}

class _BookingBottomSheetState extends ConsumerState<BookingBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _pickupController = TextEditingController();
  final _dropController = TextEditingController();
  final _purposeController = TextEditingController();
  final _searchController = TextEditingController();

  final MapController _mapController = MapController();
  final List<DragMarker> _markers = [];
  LatLng? _pickupLatLng;
  LatLng? _dropLatLng;
  final List<LatLng> _polylineCoordinates = [];
  String? _distance;
  String? _time;
  Timer? _debounce;

  @override
  void dispose() {
    _pickupController.dispose();
    _dropController.dispose();
    _purposeController.dispose();
    _searchController.dispose();
    _mapController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _submitBooking() async {
    if (_formKey.currentState!.validate()) {
      if (widget.initialStartDate == null || widget.initialEndDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Date range is not selected')),
        );
        return;
      }

      if (_pickupLatLng == null || _dropLatLng == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Please select pickup and drop locations on the map')),
        );
        return;
      }

      ref.read(bookingControllerProvider.notifier).createBooking(
            vehicleId: widget.vehicle.id,
            fromDateTime: widget.initialStartDate!,
            toDateTime: widget.initialEndDate!,
            pickupLocation: _pickupController.text,
            dropLocation: _dropController.text,
            purpose: _purposeController.text,
          );
    }
  }

  void _onTap(TapPosition tapPosition, LatLng latLng) async {
    if (_pickupLatLng == null) {
      await _reverseGeocode(latLng, _pickupController);
      setState(() {
        _pickupLatLng = latLng;
        _markers.clear();
        _markers.add(_buildMarker(latLng, isPickup: true));
      });
    } else if (_dropLatLng == null) {
      await _reverseGeocode(latLng, _dropController);
      setState(() {
        _dropLatLng = latLng;
        _markers.add(_buildMarker(latLng, isPickup: false));
      });
      _getRoute();
    } else {
      await _reverseGeocode(latLng, _pickupController);
      setState(() {
        _markers.clear();
        _polylineCoordinates.clear();
        _distance = null;
        _time = null;
        _dropController.clear();

        _pickupLatLng = latLng;
        _dropLatLng = null;
        _markers.add(_buildMarker(latLng, isPickup: true));
      });
    }
  }

  DragMarker _buildMarker(LatLng latLng, {required bool isPickup}) {
    return DragMarker(
      point: latLng,
      size: const Size(80.0, 80.0),
      builder: (context, pos, isDragging) {
        return Icon(
          Icons.location_on,
          color: isPickup ? Colors.green : Colors.red,
          size: 40,
        );
      },
      onDragEnd: (details, point) {
        setState(() {
          if (isPickup) {
            _pickupLatLng = point;
            _reverseGeocode(point, _pickupController);
          } else {
            _dropLatLng = point;
            _reverseGeocode(point, _dropController);
          }
        });

        if (_pickupLatLng != null && _dropLatLng != null) {
          _getRoute();
        }
      },
    );
  }

  Future<void> _reverseGeocode(
      LatLng latLng, TextEditingController controller) async {
    try {
      final placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        String address = [
          place.name,
          place.street,
          place.locality,
          place.postalCode,
          place.country
        ].where((e) => e != null && e.isNotEmpty).toSet().join(', ');

        controller.text = address;
      }
    } catch (e) {
      debugPrint('Error reverse geocoding: $e');
      controller.text =
          '${latLng.latitude.toStringAsFixed(6)}, ${latLng.longitude.toStringAsFixed(6)}';
    }
  }

  Future<void> _getRoute() async {
    if (_pickupLatLng == null || _dropLatLng == null) return;

    final dio = Dio();
    final url = 'http://router.project-osrm.org/route/v1/driving/'
        '${_pickupLatLng!.longitude},${_pickupLatLng!.latitude};'
        '${_dropLatLng!.longitude},${_dropLatLng!.latitude}?overview=full&geometries=geojson';

    try {
      final response = await dio.get(url);
      final data = response.data;
      final routes = data['routes'] as List;
      if (routes.isNotEmpty) {
        final route = routes.first;
        final geometry = route['geometry']['coordinates'] as List;
        final points =
            geometry.map((p) => LatLng(p[1] as double, p[0] as double)).toList();

        final distanceInMeters = route['distance'] as double;
        final timeInSeconds = route['duration'] as double;

        setState(() {
          _polylineCoordinates.clear();
          _polylineCoordinates.addAll(points);
          _distance = '${(distanceInMeters / 1000).toStringAsFixed(2)} km';

          final int minutes = (timeInSeconds / 60).round();
          final int hours = minutes ~/ 60;
          final int remainingMinutes = minutes % 60;

          if (hours > 0) {
            _time = '$hours hr $remainingMinutes min';
          } else {
            _time = '$minutes min';
          }
        });
      }
    } catch (e) {
      debugPrint('Error getting route: $e');
    }
  }

  Future<void> _getCurrentLocation() async {
    final status = await Geolocator.checkPermission();
    if (status == LocationPermission.denied) {
      final result = await Geolocator.requestPermission();
      if (result != LocationPermission.whileInUse &&
          result != LocationPermission.always) {
        return;
      }
    }

    try {
      final position = await Geolocator.getCurrentPosition();
      final latLng = LatLng(position.latitude, position.longitude);

      _mapController.move(latLng, 15.0);

      await _reverseGeocode(latLng, _pickupController);

      setState(() {
        _markers.clear();
        _polylineCoordinates.clear();
        _distance = null;
        _time = null;
        _dropController.clear();
        _dropLatLng = null;

        _pickupLatLng = latLng;
        _markers.add(_buildMarker(latLng, isPickup: true));
      });
    } catch (e) {
      debugPrint('Error getting current location: $e');
    }
  }

  void _zoomIn() {
    _mapController.move(
        _mapController.camera.center, _mapController.camera.zoom + 1);
  }

  void _zoomOut() {
    _mapController.move(
        _mapController.camera.center, _mapController.camera.zoom - 1);
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchPlace(query);
    });
  }

  Future<void> _searchPlace(String query) async {
    try {
      final locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final location = locations.first;
        final latLng = LatLng(location.latitude, location.longitude);
        _mapController.move(latLng, 15.0);
      }
    } catch (e) {
      debugPrint('Error searching for place: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<BookingState>(bookingControllerProvider, (previous, next) {
      next.maybeWhen(
        success: (message) {
          if (!mounted) return;
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        },
        error: (error) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error)),
          );
        },
        orElse: () {},
      );
    });

    final bookingState = ref.watch(bookingControllerProvider);
    final isLoading = bookingState.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    final dateFormat = DateFormat('MMM d, yyyy - hh:mm a');

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16.0,
        right: 16.0,
        top: 24.0,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Book ${widget.vehicle.name}',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),

              // Display Dates
              if (widget.initialStartDate != null)
                _buildReadOnlyDateField(
                  'From',
                  dateFormat.format(widget.initialStartDate!),
                ),
              if (widget.initialEndDate != null)
                _buildReadOnlyDateField(
                  'To',
                  dateFormat.format(widget.initialEndDate!),
                ),
              const Divider(height: 24),

              SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        initialCenter: const LatLng(6.9271, 79.8612),
                        initialZoom: 13.0,
                        onTap: _onTap,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.vehiclebooking',
                        ),
                        PolylineLayer(
                          polylines: [
                            Polyline(
                              points: _polylineCoordinates,
                              strokeWidth: 4.0,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        DragMarkers(markers: _markers),
                      ],
                    ),
                    Positioned(
                      top: 8.0,
                      right: 8.0,
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: _zoomIn,
                            icon: const Icon(Icons.add, color: Colors.black),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          IconButton(
                            onPressed: _zoomOut,
                            icon: const Icon(Icons.remove, color: Colors.black),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          IconButton(
                            onPressed: _getCurrentLocation,
                            icon: const Icon(Icons.my_location,
                                color: Colors.black),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 8.0,
                      left: 8.0,
                      right: 80.0,
                      child: TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          labelText: 'Search',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: _onSearchChanged,
                      ),
                    ),
                  ],
                ),
              ),

              if (_distance != null && _time != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(children: [
                          const Icon(Icons.route, size: 16, color: Colors.blue),
                          const SizedBox(width: 4),
                          Text('Distance: $_distance',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ]),
                        Row(children: [
                          const Icon(Icons.access_time,
                              size: 16, color: Colors.blue),
                          const SizedBox(width: 4),
                          Text('Time: $_time',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ]),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _pickupController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Pickup Location',
                  prefixIcon: Icon(Icons.location_on, color: Colors.green),
                  helperText: 'Tap on map to set pickup',
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please select a pickup location on the map'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _dropController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Drop-off Location',
                  prefixIcon: Icon(Icons.location_on, color: Colors.red),
                  helperText: 'Tap on map to set drop-off',
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please select a drop-off location on the map'
                    : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _purposeController,
                decoration: const InputDecoration(
                  labelText: 'Purpose of Booking',
                  prefixIcon: Icon(Icons.description_outlined),
                ),
                maxLines: 2,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please describe the purpose'
                    : null,
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: isLoading ? null : _submitBooking,
                  child: isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                      : const Text('Confirm Booking'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReadOnlyDateField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text('$label: ',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

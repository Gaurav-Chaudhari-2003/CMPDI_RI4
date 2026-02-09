class ApiConstants {
  // Use the ngrok URL for wider accessibility
  static const String baseUrl = 'https://8099-2001-4490-448d-e73e-fd96-d0e-ba57-dd63.ngrok-free.app/vehicle_booking/api';

  // Auth
  static const String loginUrl = '/auth/login.php';
  static const String logoutUrl = '/auth/logout.php';
  static const String userProfileUrl = '/auth/user.php'; // Endpoint to verify token

  // Vehicles
  static const String vehicleListUrl = '/vehicles/list.php';
  static const String vehicleDetailUrl = '/vehicles/detail.php';

  // Bookings
  static const String bookingListUrl = '/bookings/list.php';
  static const String bookingViewUrl = '/bookings/view.php';
  static const String bookingCreateUrl = '/bookings/create.php';
  static const String bookingCancelUrl = '/bookings/cancel.php';

}

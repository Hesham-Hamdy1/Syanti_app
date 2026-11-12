class MockData {
  // USERS

  static List<Map<String, dynamic>> mockUsers = [
    {
      'name': 'Omar',
      'email': 'omar@gmail.com',
      'phone': '01000000001',
      'password': '123456',
      'userType': 'carOwner',
    },
    {
      'name': 'Ahmed',
      'email': 'ahmed@gmail.com',
      'phone': '01000000002',
      'password': '123456',
      'userType': 'mechanic',
    },
  ];

  // CURRENT USER

  static Map<String, dynamic>? currentUser;

  // CARS

  static List<Map<String, dynamic>> mockCars = [
    {
      'id': 1,
      'ownerPhone': '01000000001',
      'brand': 'BMW',
      'year': 2022,
      'plate': 'ABC 1234',
      'km': 25000,
    },
    {
      'id': 2,
      'ownerPhone': '01000000001',
      'brand': 'Hyundai',
      'year': 2020,
      'plate': 'XYZ 5678',
      'km': 45000,
    },
  ];

  // MECHANICS

  static List<Map<String, dynamic>> mockMechanics = [
    {
      'phone': '01000000002',
      'workshopName': 'Auto Care Center',
      'specialty': 'Engine Maintenance',
      'address': 'Beni Suef - Egypt',
    },
  ];

  // REQUESTS

  static List<Map<String, dynamic>> mockRequests = [
    {
      'id': 1,
      'ownerPhone': '01000000001',
      'carId': 1,
      'mechanicPhone': '01000000002',
      'serviceType': 'Oil Change',
      'notes': 'Engine oil needs replacement',
      'status': 'pending',
      'createdAt': '2026-11-01',
    },
    {
      'id': 2,
      'ownerPhone': '01000000001',
      'carId': 2,
      'mechanicPhone': '01000000002',
      'serviceType': 'Brake Maintenance',
      'notes': 'Check the brake system',
      'status': 'completed',
      'createdAt': '2026-11-02',
    },
  ];

  // MAINTENANCE RECORDS

  static List<Map<String, dynamic>> mockMaintenanceRecords = [
    {
      'id': 1,
      'carId': 2,
      'requestId': 2,
      'title': 'Brake Maintenance',
      'date': '2026-11-02',
    },
  ];
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:syanti_app/data/mock_data.dart';
import 'package:syanti_app/screens/auth/login_screen.dart';
import 'package:syanti_app/screens/cars/car_details_screen.dart';
import 'package:syanti_app/screens/cars/home_screen.dart';
import 'package:syanti_app/screens/maintenance/maintenance_history_screen.dart';
import 'package:syanti_app/screens/mechanic/mechanic_dashboard_screen.dart';
import 'package:syanti_app/screens/requests/mechanic_requests_screen.dart';
import 'package:syanti_app/screens/requests/mechanics_list_screen.dart';
import 'package:syanti_app/screens/requests/my_requests_screen.dart';
import 'package:syanti_app/theme/app_theme.dart';

void main() {
  setUp(() {
    MockData.currentUser = null;
    MockData.mockRequests = <Map<String, dynamic>>[
      {
        'id': 7,
        'ownerPhone': '01000000001',
        'carId': 1,
        'mechanicPhone': '01000000002',
        'serviceType': 'Oil Change',
        'notes': 'Engine oil needs replacement',
        'status': 'pending',
        'createdAt': '2026-11-12',
      },
    ];
    MockData.mockMaintenanceRecords = <Map<String, dynamic>>[];
  });

  Widget wrap(Widget child) {
    return MaterialApp(theme: AppTheme.dark, home: child);
  }

  Future<void> loginAs(WidgetTester tester, String email) async {
    await tester.pumpWidget(wrap(const LoginScreen()));
    await tester.enterText(find.byType(TextFormField).at(0), email);
    await tester.enterText(find.byType(TextFormField).at(1), '123456');
    await tester.tap(find.widgetWithText(ElevatedButton, 'تسجيل الدخول'));
    await tester.pumpAndSettle();
  }

  testWidgets('login opens the car owner home for a car owner', (
    WidgetTester tester,
  ) async {
    await loginAs(tester, 'omar@gmail.com');

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(MockData.currentUser?['userType'], 'carOwner');
  });

  testWidgets('login opens the mechanic dashboard for a mechanic', (
    WidgetTester tester,
  ) async {
    await loginAs(tester, 'ahmed@gmail.com');

    expect(find.byType(MechanicDashboardScreen), findsOneWidget);
    expect(MockData.currentUser?['userType'], 'mechanic');
  });

  testWidgets('mechanic can log out back to the login screen', (
    WidgetTester tester,
  ) async {
    MockData.currentUser = MockData.mockUsers[1];

    await tester.pumpWidget(wrap(const MechanicDashboardScreen()));
    await tester.tap(find.byIcon(Icons.logout));
    await tester.pumpAndSettle();

    expect(MockData.currentUser, isNull);
    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('owner home opens the shared requests and workshops', (
    WidgetTester tester,
  ) async {
    MockData.currentUser = MockData.mockUsers[0];

    await tester.pumpWidget(wrap(const HomeScreen()));

    await tester.tap(find.byIcon(Icons.receipt_long_outlined));
    await tester.pumpAndSettle();
    expect(find.byType(MyRequestsScreen), findsOneWidget);
    expect(find.text('Oil Change'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    await tester.tap(find.text('طلب صيانة'));
    await tester.pumpAndSettle();
    expect(find.byType(MechanicsListScreen), findsOneWidget);
  });

  testWidgets('owner sees the request without mechanic actions', (
    WidgetTester tester,
  ) async {
    MockData.currentUser = MockData.mockUsers[0];

    await tester.pumpWidget(wrap(const MyRequestsScreen()));
    await tester.tap(find.text('Oil Change'));
    await tester.pumpAndSettle();

    expect(find.text('قبول الطلب'), findsNothing);
    expect(find.text('تعليم الطلب كمكتمل'), findsNothing);
  });

  testWidgets('mechanic completes the request and one record is added', (
    WidgetTester tester,
  ) async {
    MockData.currentUser = MockData.mockUsers[1];

    await tester.pumpWidget(wrap(const MechanicRequestsScreen()));

    await tester.tap(find.text('Oil Change'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('قبول الطلب'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(MockData.mockRequests.single['status'], 'accepted');
    expect(MockData.mockMaintenanceRecords, isEmpty);

    await tester.tap(find.text('Oil Change'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('تعليم الطلب كمكتمل'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(MockData.mockRequests.single['status'], 'completed');
    expect(MockData.mockMaintenanceRecords, hasLength(1));
    expect(MockData.mockMaintenanceRecords.single['requestId'], 7);

    await tester.tap(find.text('Oil Change'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(MockData.mockMaintenanceRecords, hasLength(1));
  });

  testWidgets('car details opens the maintenance history of the car', (
    WidgetTester tester,
  ) async {
    MockData.currentUser = MockData.mockUsers[0];
    MockData.mockMaintenanceRecords = <Map<String, dynamic>>[
      {
        'id': 1,
        'carId': 2,
        'requestId': 2,
        'title': 'Brake Maintenance',
        'date': '2026-11-02',
      },
    ];

    await tester.pumpWidget(
      wrap(CarDetailsScreen(car: MockData.mockCars[1])),
    );

    await tester.tap(find.text('سجل الصيانة'));
    await tester.pumpAndSettle();

    expect(find.byType(MaintenanceHistoryScreen), findsOneWidget);
    expect(find.text('Brake Maintenance'), findsOneWidget);
  });
}

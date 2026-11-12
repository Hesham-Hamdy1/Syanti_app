import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:syanti_app/data/mock_data.dart';
import 'package:syanti_app/screens/requests/create_request_screen.dart';
import 'package:syanti_app/screens/requests/mechanic_details_screen.dart';
import 'package:syanti_app/screens/requests/mechanics_list_screen.dart';
import 'package:syanti_app/theme/app_theme.dart';

void main() {
  setUp(() {
    MockData.currentUser = MockData.mockUsers[0];
  });

  Widget wrap(Widget child) {
    return MaterialApp(theme: AppTheme.dark, home: child);
  }

  testWidgets('mechanics list shows the available workshop', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(wrap(const MechanicsListScreen()));

    expect(find.text('Auto Care Center'), findsOneWidget);
  });

  testWidgets('mechanic details shows the request action', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      wrap(MechanicDetailsScreen(mechanic: MockData.mockMechanics.first)),
    );

    expect(find.text('اطلب خدمة'), findsOneWidget);
  });

  testWidgets('create request adds a pending request to the shared list', (
    WidgetTester tester,
  ) async {
    final int before = MockData.mockRequests.length;

    await tester.pumpWidget(
      wrap(CreateRequestScreen(mechanic: MockData.mockMechanics.first)),
    );

    await tester.tap(find.byType(DropdownButton<Object>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('BMW - 2022 (ABC 1234)').last);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('تغيير زيت وفلاتر').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('إنشاء الطلب'));
    await tester.pumpAndSettle();

    expect(MockData.mockRequests.length, before + 1);

    final Map<String, dynamic> added = MockData.mockRequests.last;
    expect(added['status'], 'pending');
    expect(added['ownerPhone'], MockData.mockUsers[0]['phone']);
    expect(added['mechanicPhone'], MockData.mockMechanics.first['phone']);
    expect(added['serviceType'], 'تغيير زيت وفلاتر');
    expect(added['carId'], 1);
  });
}

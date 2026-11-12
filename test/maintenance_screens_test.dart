import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:syanti_app/screens/maintenance/maintenance_history_screen.dart';
import 'package:syanti_app/screens/maintenance/notifications_screen.dart';
import 'package:syanti_app/theme/app_theme.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(theme: AppTheme.dark, home: child);
  }

  testWidgets('maintenance history shows only the records of the car', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      wrap(const MaintenanceHistoryScreen(carId: 2)),
    );

    expect(find.text('Brake Maintenance'), findsOneWidget);
    expect(find.text('Oil Change'), findsNothing);
  });

  testWidgets('maintenance history shows an empty state without records', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      wrap(const MaintenanceHistoryScreen(carId: 99)),
    );

    expect(find.textContaining('مفيش'), findsOneWidget);
  });

  testWidgets('notifications screen shows the four demo events', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(wrap(const NotificationsScreen()));

    expect(find.textContaining('تم إنشاء الطلب'), findsOneWidget);
    expect(find.textContaining('تم قبول الطلب'), findsOneWidget);
    expect(find.textContaining('تم رفض الطلب'), findsOneWidget);
    expect(find.textContaining('تم إكمال الطلب'), findsOneWidget);
  });
}

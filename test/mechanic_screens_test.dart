import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:syanti_app/data/mock_data.dart';
import 'package:syanti_app/screens/mechanic/mechanic_profile_screen.dart';
import 'package:syanti_app/screens/mechanic/mechanic_requests_preview_screen.dart';
import 'package:syanti_app/theme/app_theme.dart';

void main() {
  setUp(() {
    MockData.currentUser = MockData.mockUsers[1];
    final Map<String, dynamic> workshop = MockData.mockMechanics.first;
    workshop['workshopName'] = 'Auto Care Center';
    workshop['specialty'] = 'Engine Maintenance';
    workshop['address'] = 'Beni Suef - Egypt';
  });

  Widget wrap(Widget child) {
    return MaterialApp(theme: AppTheme.dark, home: child);
  }

  testWidgets('workshop profile saves data for the current mechanic', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(wrap(const MechanicProfileScreen()));

    await tester.enterText(find.byType(TextFormField).at(0), 'Workshop One');
    await tester.enterText(find.byType(TextFormField).at(1), 'Brakes');
    await tester.enterText(find.byType(TextFormField).at(2), 'Cairo');
    await tester.tap(find.text('حفظ البيانات'));
    await tester.pumpAndSettle();

    expect(MockData.mockMechanics.first['workshopName'], 'Workshop One');
    expect(MockData.mockMechanics.first['specialty'], 'Brakes');
    expect(MockData.mockMechanics.first['address'], 'Cairo');
  });

  testWidgets('requests preview shows the shared requests of the mechanic', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(wrap(const MechanicRequestsPreviewScreen()));

    expect(find.text('Oil Change'), findsOneWidget);
    expect(find.text('Brake Maintenance'), findsOneWidget);
  });

  testWidgets('requests preview shows an empty state without requests', (
    WidgetTester tester,
  ) async {
    MockData.currentUser = <String, dynamic>{
      'phone': '01000000099',
      'userType': 'mechanic',
    };

    await tester.pumpWidget(wrap(const MechanicRequestsPreviewScreen()));

    expect(find.textContaining('مفيش'), findsOneWidget);
  });
}

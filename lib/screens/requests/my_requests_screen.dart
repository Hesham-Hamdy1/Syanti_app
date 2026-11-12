import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../data/request_mapping.dart';
import '../../theme/app_theme.dart';
import 'completed_requests_screen.dart';
import 'mechanic_requests_screen.dart';
import 'request_details_screen.dart';
import 'widgets/request_card_widget.dart';
import 'widgets/request_filter_chip_widget.dart';
import 'widgets/request_screen_shell_widget.dart';

class MyRequestsScreen extends StatefulWidget {
  const MyRequestsScreen({super.key});

  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {
  List<Map<String, dynamic>> get _requests {
    final String? phone = MockData.currentUser?['phone']?.toString();
    if (phone == null || phone.isEmpty) {
      return <Map<String, dynamic>>[];
    }

    return MockData.mockRequests
        .where((Map<String, dynamic> request) {
          return request['ownerPhone']?.toString() == phone;
        })
        .toList();
  }

  Future<void> _openRequest(Map<String, dynamic> request) async {
    final RequestCardData? updatedRequest =
        await Navigator.push<RequestCardData>(
          context,
          MaterialPageRoute<RequestCardData>(
            builder: (BuildContext context) =>
                RequestDetailsScreen(request: requestCardFromMap(request)),
          ),
        );

    if (!mounted || updatedRequest == null) {
      return;
    }

    // نفس عنصر الطلب المشترك هو اللي بيتحدّث، فباقي الشاشات بتشوف الحالة الجديدة
    setState(() {
      writeRequestStatus(request, updatedRequest.status);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> requests = _requests;
    final bool isMechanic =
        MockData.currentUser?['userType']?.toString() == 'mechanic';

    return RequestScreenShellWidget(
      title: 'طلباتي',
      actions: <Widget>[
        IconButton(
          tooltip: 'الطلبات المكتملة',
          onPressed: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    const CompletedRequestsScreen(),
              ),
            );
          },
          icon: const Icon(Icons.history),
        ),
        if (isMechanic)
          IconButton(
            tooltip: 'طلبات الميكانيكي',
            onPressed: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      const MechanicRequestsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.build_outlined),
          ),
      ],
      body: ListView(
        padding: const EdgeInsets.fromLTRB(17, 12, 17, 20),
        children: <Widget>[
          Text(
            'تابع حالة طلبات الصيانة الخاصة بك',
            style: AppText.body.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                RequestFilterChipWidget(label: 'الكل', selected: true),
                SizedBox(width: 8),
                RequestFilterChipWidget(label: 'قيد الانتظار'),
                SizedBox(width: 8),
                RequestFilterChipWidget(label: 'قيد الصيانة'),
                SizedBox(width: 8),
                RequestFilterChipWidget(label: 'مكتملة'),
              ],
            ),
          ),
          const SizedBox(height: 17),
          if (requests.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                'مفيش طلبات صيانة لحد الآن',
                textAlign: TextAlign.center,
                style: AppText.body.copyWith(color: AppColors.textSecondary),
              ),
            )
          else
            ...requests.map(
              (Map<String, dynamic> request) => RequestCardWidget(
                request: requestCardFromMap(request),
                onTap: () => _openRequest(request),
              ),
            ),
        ],
      ),
    );
  }
}

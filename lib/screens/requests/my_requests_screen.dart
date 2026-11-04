import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'widgets/request_card_data.dart';
import 'widgets/request_card_widget.dart';
import 'widgets/request_filter_chip_widget.dart';
import 'widgets/request_screen_shell_widget.dart';
import 'widgets/request_status.dart';
import 'completed_requests_screen.dart';
import 'mechanic_requests_screen.dart';
import 'request_details_screen.dart';

class MyRequestsScreen extends StatefulWidget {
  const MyRequestsScreen({super.key});

  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {
  final List<RequestCardData> _requests = <RequestCardData>[
    RequestCardData(
      service: 'تغيير زيت المحرك',
      car: 'تويوتا كورولا • 2022',
      date: '04 نوفمبر 2026 • 10:30 ص',
      workshop: 'مركز الأمان لصيانة السيارات',
      status: RequestStatus.inProgress,
    ),
    RequestCardData(
      service: 'فحص الفرامل',
      car: 'هيونداي إلنترا • 2020',
      date: '02 نوفمبر 2026 • 02:00 م',
      workshop: 'ورشة النخبة للسيارات',
      status: RequestStatus.pending,
    ),
    RequestCardData(
      service: 'صيانة التكييف',
      car: 'تويوتا كورولا • 2022',
      date: '28 أكتوبر 2026 • 11:15 ص',
      workshop: 'مركز الأمان لصيانة السيارات',
      status: RequestStatus.completed,
    ),
    RequestCardData(
      service: 'تغيير الإطارات',
      car: 'هيونداي إلنترا • 2020',
      date: '20 أكتوبر 2026 • 09:00 ص',
      workshop: 'ورشة النخبة للسيارات',
      status: RequestStatus.rejected,
    ),
  ];

  Future<void> _openRequest(int index) async {
    final RequestCardData? updatedRequest =
        await Navigator.push<RequestCardData>(
          context,
          MaterialPageRoute<RequestCardData>(
            builder: (BuildContext context) =>
                RequestDetailsScreen(request: _requests[index]),
          ),
        );

    if (!mounted || updatedRequest == null) {
      return;
    }

    setState(() {
      _requests[index] = updatedRequest;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          ..._requests.asMap().entries.map(
            (MapEntry<int, RequestCardData> entry) => RequestCardWidget(
              request: entry.value,
              onTap: () => _openRequest(entry.key),
            ),
          ),
        ],
      ),
    );
  }
}

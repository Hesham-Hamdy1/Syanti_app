import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'widgets/request_card_data.dart';
import 'widgets/request_card_widget.dart';
import 'widgets/request_screen_shell_widget.dart';
import 'widgets/request_status.dart';

class CompletedRequestsScreen extends StatelessWidget {
  const CompletedRequestsScreen({super.key});

  static const List<RequestCardData> _requests = <RequestCardData>[
    RequestCardData(
      service: 'تغيير زيت المحرك',
      car: 'تويوتا كورولا • 2022',
      date: '12 أكتوبر 2026 • 11:45 ص',
      workshop: 'مركز الأمان لصيانة السيارات',
      status: RequestStatus.completed,
    ),
    RequestCardData(
      service: 'فحص الفرامل',
      car: 'هيونداي إلنترا • 2020',
      date: '03 أغسطس 2026 • 04:20 م',
      workshop: 'ورشة النخبة للسيارات',
      status: RequestStatus.completed,
    ),
    RequestCardData(
      service: 'صيانة التكييف',
      car: 'تويوتا كورولا • 2022',
      date: '15 يونيو 2026 • 01:10 م',
      workshop: 'مركز الأمان لصيانة السيارات',
      status: RequestStatus.completed,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return RequestScreenShellWidget(
      title: 'الطلبات المكتملة',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(17, 12, 17, 20),
        children: <Widget>[
          Text(
            'طلبات الصيانة التي تم إنجازها',
            style: AppText.body.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 17),
          ..._requests.map(
            (RequestCardData request) => RequestCardWidget(request: request),
          ),
        ],
      ),
    );
  }
}

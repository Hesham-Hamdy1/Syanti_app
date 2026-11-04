import 'package:flutter/material.dart';

import 'widgets/request_card_data.dart';
import 'widgets/request_card_widget.dart';
import 'widgets/request_filter_chip_widget.dart';
import 'widgets/request_screen_shell_widget.dart';
import 'widgets/request_section_heading_widget.dart';
import 'widgets/request_status.dart';
import 'widgets/request_summary_banner_widget.dart';
import 'request_details_screen.dart';

class MechanicRequestsScreen extends StatefulWidget {
  const MechanicRequestsScreen({super.key});

  @override
  State<MechanicRequestsScreen> createState() => _MechanicRequestsScreenState();
}

class _MechanicRequestsScreenState extends State<MechanicRequestsScreen> {
  final List<RequestCardData> _requests = <RequestCardData>[
    RequestCardData(
      service: 'تغيير زيت المحرك',
      car: 'تويوتا كورولا • 2022',
      date: '04 نوفمبر 2026 • 10:30 ص',
      workshop: 'مركز الأمان لصيانة السيارات',
      status: RequestStatus.pending,
      owner: 'أحمد محمد',
    ),
    RequestCardData(
      service: 'فحص شامل للسيارة',
      car: 'نيسان صني • 2021',
      date: '04 نوفمبر 2026 • 12:00 م',
      workshop: 'مركز الأمان لصيانة السيارات',
      status: RequestStatus.pending,
      owner: 'محمود علي',
    ),
    RequestCardData(
      service: 'فحص الفرامل',
      car: 'هيونداي إلنترا • 2020',
      date: '03 نوفمبر 2026 • 03:30 م',
      workshop: 'مركز الأمان لصيانة السيارات',
      status: RequestStatus.accepted,
      owner: 'سارة خالد',
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
      title: 'طلبات الصيانة',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(17, 12, 17, 20),
        children: <Widget>[
          const RequestSummaryBannerWidget(),
          const SizedBox(height: 16),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                RequestFilterChipWidget(label: 'الكل', selected: true),
                SizedBox(width: 8),
                RequestFilterChipWidget(label: 'جديدة'),
                SizedBox(width: 8),
                RequestFilterChipWidget(label: 'مقبولة'),
                SizedBox(width: 8),
                RequestFilterChipWidget(label: 'قيد الصيانة'),
              ],
            ),
          ),
          const SizedBox(height: 17),
          const RequestSectionHeadingWidget('الطلبات الواردة'),
          ..._requests.asMap().entries.map(
            (MapEntry<int, RequestCardData> entry) => RequestCardWidget(
              request: entry.value,
              showOwner: true,
              showDetailsButton: true,
              onTap: () => _openRequest(entry.key),
            ),
          ),
        ],
      ),
    );
  }
}

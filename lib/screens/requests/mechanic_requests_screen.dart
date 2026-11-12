import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../data/request_mapping.dart';
import '../../theme/app_theme.dart';
import 'request_details_screen.dart';
import 'widgets/request_card_widget.dart';
import 'widgets/request_filter_chip_widget.dart';
import 'widgets/request_screen_shell_widget.dart';
import 'widgets/request_section_heading_widget.dart';
import 'widgets/request_summary_banner_widget.dart';

class MechanicRequestsScreen extends StatefulWidget {
  const MechanicRequestsScreen({super.key});

  @override
  State<MechanicRequestsScreen> createState() => _MechanicRequestsScreenState();
}

class _MechanicRequestsScreenState extends State<MechanicRequestsScreen> {
  List<Map<String, dynamic>> get _requests {
    final String? phone = MockData.currentUser?['phone']?.toString();
    if (phone == null || phone.isEmpty) {
      return <Map<String, dynamic>>[];
    }

    return MockData.mockRequests
        .where((Map<String, dynamic> request) {
          return request['mechanicPhone']?.toString() == phone;
        })
        .toList();
  }

  Future<void> _openRequest(Map<String, dynamic> request) async {
    final RequestCardData? updatedRequest =
        await Navigator.push<RequestCardData>(
          context,
          MaterialPageRoute<RequestCardData>(
            builder: (BuildContext context) => RequestDetailsScreen(
              request: requestCardFromMap(request),
              canManage: true,
            ),
          ),
        );

    if (!mounted || updatedRequest == null) {
      return;
    }

    // الحالة بتتكتب في نفس الطلب المشترك، والسجل بيتضاف مرة واحدة عند الإكمال
    setState(() {
      writeRequestStatus(request, updatedRequest.status);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> requests = _requests;

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
          if (requests.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                'مفيش طلبات واردة لحد الآن',
                textAlign: TextAlign.center,
                style: AppText.body.copyWith(color: AppColors.textSecondary),
              ),
            )
          else
            ...requests.map(
              (Map<String, dynamic> request) => RequestCardWidget(
                request: requestCardFromMap(request),
                showOwner: true,
                showDetailsButton: true,
                onTap: () => _openRequest(request),
              ),
            ),
        ],
      ),
    );
  }
}

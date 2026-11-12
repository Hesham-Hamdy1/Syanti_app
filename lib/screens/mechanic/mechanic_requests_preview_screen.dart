import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../data/request_mapping.dart';
import '../../theme/app_theme.dart';
import '../requests/request_details_screen.dart';
import '../requests/widgets/request_card_widget.dart';
import '../requests/widgets/request_screen_shell_widget.dart';

class MechanicRequestsPreviewScreen extends StatefulWidget {
  const MechanicRequestsPreviewScreen({super.key});

  @override
  State<MechanicRequestsPreviewScreen> createState() =>
      _MechanicRequestsPreviewScreenState();
}

class _MechanicRequestsPreviewScreenState
    extends State<MechanicRequestsPreviewScreen> {
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

  Future<void> _openDetails(Map<String, dynamic> request) async {
    final RequestCardData? updated = await Navigator.push<RequestCardData>(
      context,
      MaterialPageRoute<RequestCardData>(
        builder: (BuildContext context) => RequestDetailsScreen(
          request: requestCardFromMap(request),
          canManage: true,
        ),
      ),
    );

    if (!mounted || updated == null) {
      return;
    }

    // شاشة التفاصيل بترجّع الحالة الجديدة، فبنكتبها في نفس الطلب المشترك
    setState(() {
      writeRequestStatus(request, updated.status);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> requests = _requests;

    return RequestScreenShellWidget(
      title: 'طلبات الصيانة',
      body: requests.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(
                    Icons.assignment_outlined,
                    size: 48,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'مفيش طلبات واردة لحد الآن',
                    style: AppText.body.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(
                AppMetrics.gutter,
                12,
                AppMetrics.gutter,
                20,
              ),
              children: <Widget>[
                Text(
                  'عندك ${requests.length} طلب',
                  style: AppText.sectionTitle,
                ),
                const SizedBox(height: 12),
                ...requests.map(
                  (Map<String, dynamic> request) => RequestCardWidget(
                    request: requestCardFromMap(request),
                    showOwner: true,
                    showDetailsButton: true,
                    onTap: () => _openDetails(request),
                  ),
                ),
              ],
            ),
    );
  }
}

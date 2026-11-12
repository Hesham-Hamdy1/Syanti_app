import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../data/request_mapping.dart';
import '../../theme/app_theme.dart';
import 'widgets/request_card_widget.dart';
import 'widgets/request_screen_shell_widget.dart';

class CompletedRequestsScreen extends StatelessWidget {
  const CompletedRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<RequestCardData> requests = MockData.mockRequests
        .where((Map<String, dynamic> request) {
          return request['status'] == 'completed' &&
              request['ownerPhone']?.toString() ==
                  MockData.currentUser?['phone']?.toString();
        })
        .map(requestCardFromMap)
        .toList();

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
          if (requests.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                'مفيش طلبات مكتملة لحد الآن',
                textAlign: TextAlign.center,
                style: AppText.body.copyWith(color: AppColors.textSecondary),
              ),
            )
          else
            ...requests.map(
              (RequestCardData request) => RequestCardWidget(request: request),
            ),
        ],
      ),
    );
  }
}

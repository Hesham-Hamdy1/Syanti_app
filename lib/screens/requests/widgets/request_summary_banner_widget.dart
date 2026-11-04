import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

class RequestSummaryBannerWidget extends StatelessWidget {
  const RequestSummaryBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.assignment_outlined, color: AppColors.primaryAction),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'لديك طلبات جديدة تحتاج إلى مراجعة',
              style: AppText.body,
            ),
          ),
          Text(
            '2',
            style: AppText.sectionTitle.copyWith(
              color: AppColors.primaryAction,
            ),
          ),
        ],
      ),
    );
  }
}

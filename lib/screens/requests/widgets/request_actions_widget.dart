import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import 'request_status.dart';

class RequestActionsWidget extends StatelessWidget {
  const RequestActionsWidget({
    required this.status,
    required this.onAccept,
    required this.onReject,
    required this.onComplete,
    super.key,
  });

  final RequestStatus status;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    if (status == RequestStatus.completed ||
        status == RequestStatus.rejected) {
      return const SizedBox.shrink();
    }

    if (status == RequestStatus.accepted ||
        status == RequestStatus.inProgress) {
      return SizedBox(
        width: double.infinity,
        height: 45,
        child: ElevatedButton(
          onPressed: onComplete,
          child: Text('تعليم الطلب كمكتمل', style: AppText.body),
        ),
      );
    }

    // الحالة pending، فالميكانيكي بيقبل أو يرفض، والإكمال بعد القبول
    return Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 45,
            child: OutlinedButton(
              onPressed: onReject,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryAction,
                side: const BorderSide(color: AppColors.primaryAction),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'رفض الطلب',
                style: AppText.body.copyWith(color: AppColors.primaryAction),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            height: 45,
            child: ElevatedButton(
              onPressed: onAccept,
              child: Text('قبول الطلب', style: AppText.body),
            ),
          ),
        ),
      ],
    );
  }
}

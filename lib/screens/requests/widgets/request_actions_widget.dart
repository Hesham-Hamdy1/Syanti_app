import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

class RequestActionsWidget extends StatelessWidget {
  const RequestActionsWidget({
    required this.onAccept,
    required this.onReject,
    required this.onComplete,
    super.key,
  });

  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
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
                    style: AppText.body.copyWith(
                      color: AppColors.primaryAction,
                    ),
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
        ),
        const SizedBox(height: 9),
        SizedBox(
          width: double.infinity,
          height: 42,
          child: TextButton(
            onPressed: onComplete,
            child: Text(
              'تعليم الطلب كمكتمل',
              style: AppText.body.copyWith(color: AppColors.successStatus),
            ),
          ),
        ),
      ],
    );
  }
}

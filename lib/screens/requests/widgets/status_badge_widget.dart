import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import 'request_status.dart';

class RequestStatusBadge extends StatelessWidget {
  const RequestStatusBadge({required this.status, super.key});

  final RequestStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.label,
        style: AppText.fieldLabel.copyWith(color: status.color),
        maxLines: 1,
      ),
    );
  }
}

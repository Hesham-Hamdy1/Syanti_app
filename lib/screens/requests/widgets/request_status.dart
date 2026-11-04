import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

enum RequestStatus { pending, accepted, inProgress, completed, rejected }

extension RequestStatusPresentation on RequestStatus {
  String get label {
    switch (this) {
      case RequestStatus.pending:
        return 'قيد الانتظار';
      case RequestStatus.accepted:
        return 'تم القبول';
      case RequestStatus.inProgress:
        return 'قيد الصيانة';
      case RequestStatus.completed:
        return 'مكتمل';
      case RequestStatus.rejected:
        return 'مرفوض';
    }
  }

  Color get color {
    switch (this) {
      case RequestStatus.pending:
        return AppColors.warningStatus;
      case RequestStatus.accepted:
      case RequestStatus.inProgress:
      case RequestStatus.completed:
        return AppColors.successStatus;
      case RequestStatus.rejected:
        return AppColors.primaryAction;
    }
  }
}

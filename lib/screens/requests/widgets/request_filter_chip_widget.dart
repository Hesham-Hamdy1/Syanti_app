import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

class RequestFilterChipWidget extends StatelessWidget {
  const RequestFilterChipWidget({
    required this.label,
    this.selected = false,
    super.key,
  });

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? AppColors.primaryAction : AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? AppColors.primaryAction : AppColors.border,
        ),
      ),
      child: Text(
        label,
        style: AppText.fieldLabel.copyWith(color: AppColors.textPrimary),
      ),
    );
  }
}

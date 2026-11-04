import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

class RequestInfoLine extends StatelessWidget {
  const RequestInfoLine({required this.icon, required this.text, super.key});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, size: 15, color: AppColors.textSecondary),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            text,
            style: AppText.fieldLabel.copyWith(color: AppColors.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

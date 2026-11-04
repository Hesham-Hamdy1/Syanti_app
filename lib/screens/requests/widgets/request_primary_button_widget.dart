import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

class RequestPrimaryButtonWidget extends StatelessWidget {
  const RequestPrimaryButtonWidget({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppMetrics.buttonHeight,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}

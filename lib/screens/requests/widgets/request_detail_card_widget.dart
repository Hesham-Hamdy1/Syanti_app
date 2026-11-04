import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

class RequestDetailItem {
  const RequestDetailItem(this.label, this.value);

  final String label;
  final String value;
}

class RequestDetailCardWidget extends StatelessWidget {
  const RequestDetailCardWidget({required this.items, super.key});

  final List<RequestDetailItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: items
            .map(
              (RequestDetailItem item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        item.label,
                        style: AppText.body.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        item.value,
                        textAlign: TextAlign.left,
                        style: AppText.body,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

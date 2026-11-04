import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import 'request_card_data.dart';
import 'request_info_line_widget.dart';
import 'status_badge_widget.dart';

class RequestCardWidget extends StatelessWidget {
  const RequestCardWidget({
    required this.request,
    this.showOwner = false,
    this.showDetailsButton = false,
    this.onTap,
    super.key,
  });

  final RequestCardData request;
  final bool showOwner;
  final bool showDetailsButton;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 43,
                      height: 43,
                      decoration: BoxDecoration(
                        color: AppColors.cardBackgroundDeep,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: const Icon(
                        Icons.directions_car_outlined,
                        color: AppColors.primaryAction,
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            request.service,
                            style: AppText.cardTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            request.car,
                            style: AppText.fieldLabel.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    RequestStatusBadge(status: request.status),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: AppColors.border),
                const SizedBox(height: 10),
                if (showOwner && request.owner != null) ...<Widget>[
                  RequestInfoLine(
                    icon: Icons.person_outline,
                    text: request.owner!,
                  ),
                  const SizedBox(height: 7),
                ],
                RequestInfoLine(
                  icon: Icons.home_repair_service_outlined,
                  text: request.workshop,
                ),
                const SizedBox(height: 7),
                RequestInfoLine(
                  icon: Icons.calendar_month_outlined,
                  text: request.date,
                ),
                if (showDetailsButton) ...<Widget>[
                  const SizedBox(height: 11),
                  SizedBox(
                    width: double.infinity,
                    height: 39,
                    child: OutlinedButton(
                      onPressed: onTap,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryAction,
                        side: const BorderSide(color: AppColors.primaryAction),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'عرض التفاصيل',
                        style: AppText.body.copyWith(
                          color: AppColors.primaryAction,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

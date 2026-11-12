import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const List<_NotificationItem> _items = <_NotificationItem>[
    _NotificationItem(
      title: 'تم إنشاء الطلب',
      message: 'طلب الصيانة وصل للورشة وفي انتظار القبول.',
      icon: Icons.receipt_long_outlined,
      color: AppColors.primaryAction,
    ),
    _NotificationItem(
      title: 'تم قبول الطلب',
      message: 'الورشة قبلت الطلب وحددت ميعاد الصيانة.',
      icon: Icons.check_circle_outline,
      color: AppColors.successStatus,
    ),
    _NotificationItem(
      title: 'تم رفض الطلب',
      message: 'الورشة اعتذرت عن الطلب، تقدر تختار ورشة تانية.',
      icon: Icons.cancel_outlined,
      color: AppColors.primaryAction,
    ),
    _NotificationItem(
      title: 'تم إكمال الطلب',
      message: 'العربية خلصت، والسجل اتضاف لتفاصيل العربية.',
      icon: Icons.task_alt,
      color: AppColors.successStatus,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('الإشعارات')),
        body: SafeArea(
          child: ListView.separated(
            padding: const EdgeInsets.all(AppMetrics.gutter),
            itemCount: _items.length,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 12),
            itemBuilder: (BuildContext context, int index) =>
                _NotificationCard(item: _items[index]),
          ),
        ),
      ),
    );
  }
}

class _NotificationItem {
  const _NotificationItem({
    required this.title,
    required this.message,
    required this.icon,
    required this.color,
  });

  final String title;
  final String message;
  final IconData icon;
  final Color color;
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.item});

  final _NotificationItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppMetrics.radius),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.13),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(item.icon, color: item.color, size: 21),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(item.title, style: AppText.cardTitle),
                const SizedBox(height: 4),
                Text(
                  item.message,
                  style: AppText.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

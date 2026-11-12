import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'create_request_screen.dart';

class MechanicDetailsScreen extends StatelessWidget {
  const MechanicDetailsScreen({required this.mechanic, super.key});

  final Map<String, dynamic> mechanic;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            mechanic['workshopName']?.toString() ?? 'تفاصيل الورشة',
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppMetrics.gutter),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppMetrics.radius),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 16,
                    ),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: AppColors.cardBackgroundDeep,
                          child: const Icon(
                            Icons.storefront,
                            size: 44,
                            color: AppColors.primaryAction,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          mechanic['workshopName']?.toString() ?? 'اسم الورشة',
                          style: AppText.screenTitle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),
                        Chip(
                          label: Text(
                            mechanic['specialty']?.toString() ?? 'صيانة عامة',
                          ),
                          backgroundColor: AppColors.cardBackgroundDeep,
                          labelStyle: AppText.fieldLabel.copyWith(
                            color: AppColors.primaryAction,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(
                          Icons.phone,
                          color: AppColors.successStatus,
                        ),
                        title: const Text('رقم الهاتف'),
                        subtitle: Text(
                          mechanic['phone']?.toString() ?? 'غير متوفر',
                        ),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(
                          Icons.location_on,
                          color: AppColors.primaryAction,
                        ),
                        title: const Text('العنوان'),
                        subtitle: Text(
                          mechanic['address']?.toString() ?? 'غير متوفر',
                        ),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(
                          Icons.build_circle,
                          color: AppColors.primaryAction,
                        ),
                        title: const Text('التخصص'),
                        subtitle: Text(
                          mechanic['specialty']?.toString() ?? 'غير متوفر',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add_task),
                  label: const Text('اطلب خدمة'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            CreateRequestScreen(mechanic: mechanic),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

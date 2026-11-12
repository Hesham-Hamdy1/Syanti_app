import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import 'mechanic_details_screen.dart';

class MechanicsListScreen extends StatefulWidget {
  const MechanicsListScreen({super.key});

  @override
  State<MechanicsListScreen> createState() => _MechanicsListScreenState();
}

class _MechanicsListScreenState extends State<MechanicsListScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> mechanics = MockData.mockMechanics;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('ورش الصيانة المتاحة')),
        body: SafeArea(
          child: mechanics.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(
                          Icons.car_repair_outlined,
                          size: 80,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'لا توجد ورش صيانة متاحة حالياً',
                          style: AppText.sectionTitle,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'لم يقم أي ميكانيكي بتسجيل بيانات ورشته بعد.',
                          textAlign: TextAlign.center,
                          style: AppText.body.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(AppMetrics.gutter),
                  itemCount: mechanics.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Map<String, dynamic> mechanic = mechanics[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: CircleAvatar(
                          radius: 24,
                          backgroundColor: AppColors.cardBackgroundDeep,
                          child: const Icon(
                            Icons.build,
                            color: AppColors.primaryAction,
                          ),
                        ),
                        title: Text(
                          mechanic['workshopName']?.toString() ?? 'ورشة صيانة',
                          style: AppText.cardTitle,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 6),
                            Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.handyman_outlined,
                                  size: 15,
                                  color: AppColors.textSecondary,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    'التخصص: ${mechanic['specialty'] ?? 'عام'}',
                                    style: AppText.fieldLabel.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: <Widget>[
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 15,
                                  color: AppColors.textSecondary,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    mechanic['address']?.toString() ??
                                        'بدون عنوان',
                                    overflow: TextOverflow.ellipsis,
                                    style: AppText.fieldLabel.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  MechanicDetailsScreen(mechanic: mechanic),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

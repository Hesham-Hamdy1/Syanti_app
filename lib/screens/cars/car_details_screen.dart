import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import 'add_edit_car_screen.dart';

class CarDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> car;
  const CarDetailsScreen({super.key, required this.car});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  Future<void> _deleteCar() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: Text('حذف العربية', style: AppText.sectionTitle.copyWith(color: Colors.white)),
        content: Text('متأكد إنك عايز تحذف العربية دي؟', style: AppText.body),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('إلغاء')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('حذف', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      MockData.mockCars.removeWhere((c) => c['id'] == widget.car['id']);
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final car = widget.car;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('تفاصيل العربية', style: AppText.screenTitle),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppMetrics.gutter),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.primaryAction, width: 1.5),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.directions_car,
                            size: 80,
                            color: AppColors.primaryAction,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${car['brand']}', style: AppText.sectionTitle.copyWith(color: Colors.white)),
                                Text('الماركة', style: AppText.body),
                              ],
                            ),
                            const Divider(color: AppColors.border, height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${car['year']}', style: AppText.sectionTitle.copyWith(color: Colors.white)),
                                Text('سنة الصنع', style: AppText.body),
                              ],
                            ),
                            const Divider(color: AppColors.border, height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${car['plate']}', style: AppText.sectionTitle.copyWith(color: Colors.white)),
                                Text('رقم اللوحة', style: AppText.body),
                              ],
                            ),
                            const Divider(color: AppColors.border, height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${car['km']} كم', style: AppText.sectionTitle.copyWith(color: Colors.white)),
                                Text('الكيلومترات', style: AppText.body),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                width: double.infinity,
                height: AppMetrics.buttonHeight,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('سجل الصيانة - قريبًا')),
                    );
                  },
                  child: const Text('سجل الصيانة'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: AppMetrics.buttonHeight,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryAction,
                    side: const BorderSide(color: AppColors.primaryAction),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AddEditCarScreen(car: car)),
                    );
                    if (!mounted) return;
                    setState(() {});
                  },
                  child: const Text('تعديل العربية'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: AppMetrics.buttonHeight,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    side: const BorderSide(color: Colors.redAccent),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _deleteCar,
                  child: const Text('حذف العربية'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
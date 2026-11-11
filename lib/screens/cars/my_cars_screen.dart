import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import 'add_edit_car_screen.dart';
import 'car_details_screen.dart';

class MyCarsScreen extends StatefulWidget {
  const MyCarsScreen({super.key});

  @override
  State<MyCarsScreen> createState() => _MyCarsScreenState();
}

class _MyCarsScreenState extends State<MyCarsScreen> {
  @override
  Widget build(BuildContext context) {
    final user = MockData.currentUser;
    final myCars = MockData.mockCars
        .where((car) => car['ownerPhone'] == user?['phone'])
        .toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('عربياتي', style: AppText.screenTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppMetrics.gutter),
        child: Column(
          children: [
            Expanded(
              child: myCars.isEmpty
                  ? Center(child: Text('مفيش عربيات لسه', style: AppText.body))
                  : ListView.builder(
                      itemCount: myCars.length,
                      itemBuilder: (context, index) {
                        final car = myCars[index];
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CarDetailsScreen(car: car),
                              ),
                            );
                            if (!mounted) return;
                            setState(() {}); 
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.primaryAction),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.directions_car_outlined,
                                    color: AppColors.primaryAction,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${car['brand']}',
                                        style: AppText.sectionTitle.copyWith(color: Colors.white),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'سنة ${car['year']} - لوحة ${car['plate']}',
                                        style: AppText.body.copyWith(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_left,
                                  color: AppColors.iconLight,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: AppMetrics.buttonHeight,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddEditCarScreen()),
                  );
                  if (!mounted) return;
                  setState(() {});
                },
                child: const Text('+ إضافة عربية'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
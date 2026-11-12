import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import '../auth/profile_screen.dart';
import '../maintenance/notifications_screen.dart';
import '../requests/mechanics_list_screen.dart';
import '../requests/my_requests_screen.dart';
import 'my_cars_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _comingSoon(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$text قريباً')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = MockData.currentUser;
    final String name = user?['name'] ?? 'ضيف';
    final myCars = MockData.mockCars
        .where((car) => car['ownerPhone'] == user?['phone'])
        .toList();

    final services = [
      {'title': 'تغيير الزيت\nوالفلاتر', 'icon': Icons.water_drop_outlined},
      {'title': 'البطارية', 'icon': Icons.battery_charging_full},
      {'title': 'الصيانة الدورية', 'icon': Icons.calendar_month},
      {'title': 'الإطارات', 'icon': Icons.tire_repair},
      {'title': 'فحص شامل', 'icon': Icons.search},
      {'title': 'إصلاح الأعطال', 'icon': Icons.build},
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppMetrics.gutter, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.waving_hand_outlined,
                      color: AppColors.primaryAction,
                      size: 36,
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const ProfileScreen(),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('مرحباً $name', style: AppText.screenTitle),
                          Text(
                            'سيارتك في أمان',
                            style: AppText.body.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const MyRequestsScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.receipt_long_outlined,
                        color: AppColors.primaryAction,
                        size: 25,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const NotificationsScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.notifications_none,
                        color: AppColors.primaryAction,
                        size: 26,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                InkWell(
                  onTap: () => _comingSoon('البحث'),
                  borderRadius: BorderRadius.circular(AppMetrics.radius),
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppMetrics.radius),
                      border: Border.all(color: AppColors.iconLight),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('ابحث عن خدمة أو ورشة...', style: AppText.body.copyWith(fontSize: 13)),
                        const SizedBox(width: 10),
                        const Icon(Icons.search, color: AppColors.iconLight, size: 20),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                ClipRRect(
                  borderRadius: BorderRadius.circular(AppMetrics.radius),
                  child: SizedBox(
                    height: 130,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset('assets/images/Black Car.jpg', fit: BoxFit.cover),
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black87],
                            ),
                          ),
                        ),
                        Positioned(
                          right: 12,
                          bottom: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('صيانة احترافية لسيارتك', style: AppText.sectionTitle.copyWith(color: Colors.white, fontSize: 16)),
                              Text('لضمان أداء أفضل وعمر أطول', style: AppText.body.copyWith(color: Colors.white70, fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.directions_car_outlined, color: AppColors.primaryAction, size: 22),
                          const SizedBox(width: 10),
                          Expanded(child: Text('عدد عربياتك', style: AppText.body)),
                          Text('${myCars.length}', style: AppText.sectionTitle.copyWith(color: AppColors.primaryAction)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const MyCarsScreen()),
                                );
                                if (!mounted) return;
                                setState(() {});
                              },
                              child: const Text('عربياتي'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size.fromHeight(40),
                                foregroundColor: AppColors.primaryAction,
                                side: const BorderSide(color: AppColors.primaryAction),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppMetrics.radius)),
                              ),
                              onPressed: () {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const MechanicsListScreen(),
                                  ),
                                );
                              },
                              child: const Text('طلب صيانة'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.1,
                  children: services.map((service) {
                    return InkWell(
                      onTap: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const MechanicsListScreen(),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(AppMetrics.radius),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppMetrics.radius),
                          border: Border.all(color: AppColors.primaryAction),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(service['icon'] as IconData, size: 28, color: AppColors.primaryAction),
                            const SizedBox(height: 6),
                            Text(
                              service['title'] as String,
                              textAlign: TextAlign.center,
                              style: AppText.cardTitle.copyWith(fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import '../cars/home_screen.dart';
import '../cars/my_cars_screen.dart';
import '../requests/completed_requests_screen.dart';
import '../requests/my_requests_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _logout(BuildContext context) {
    MockData.currentUser = null;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  void _showUnavailable(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('هذه الصفحة غير متاحة حالياً')),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 55,
        child: Row(
          children: [
            Icon(icon, color: AppColors.iconLight, size: 25),
            const SizedBox(width: 12),
            Expanded(
              child: Text(title, style: AppText.body.copyWith(fontSize: 13)),
            ),
            const Icon(
              Icons.chevron_left,
              color: AppColors.textPrimary,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: selected ? AppColors.primaryAction : AppColors.iconLight,
            ),
            const SizedBox(height: 3),
            Text(
              title,
              style: AppText.navLabel.copyWith(
                fontSize: 9,
                color: selected
                    ? AppColors.primaryAction
                    : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = MockData.currentUser;

    final userName = user?['name']?.toString() ?? 'اسم المستخدم';

    final userPhone = user?['phone']?.toString() ?? 'رقم الهاتف';

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: SafeArea(
          child: Column(
            children: [
              // Header
              SizedBox(
                height: 45,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      'حسابي',
                      style: AppText.body.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () => Navigator.maybePop(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.iconLight,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppMetrics.gutter,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),

                      // User Information
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 19,
                            backgroundColor: AppColors.primaryAction,
                            child: Icon(
                              Icons.person_outline,
                              color: AppColors.textPrimary,
                              size: 23,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userName,
                                  style: AppText.body.copyWith(fontSize: 12),
                                ),
                                Text(
                                  userPhone,
                                  style: AppText.body.copyWith(
                                    fontSize: 10,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      _buildMenuItem(
                        icon: Icons.person_outline,
                        title: 'معلوماتي الشخصية',
                        onTap: () => _showUnavailable(context),
                      ),

                      _buildMenuItem(
                        icon: Icons.directions_car_outlined,
                        title: 'سياراتي',
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const MyCarsScreen(),
                            ),
                          );
                        },
                      ),

                      _buildMenuItem(
                        icon: Icons.favorite_border,
                        title: 'المحفوظة',
                        onTap: () => _showUnavailable(context),
                      ),

                      _buildMenuItem(
                        icon: Icons.settings,
                        title: 'الإعدادات',
                        onTap: () => _showUnavailable(context),
                      ),

                      _buildMenuItem(
                        icon: Icons.headset_mic_outlined,
                        title: 'المساعدة والدعم',
                        onTap: () => _showUnavailable(context),
                      ),

                      const SizedBox(height: 18),

                      // Logout
                      SizedBox(
                        height: 39,
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => _logout(context),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primaryAction,
                            side: const BorderSide(
                              color: AppColors.primaryAction,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Text(
                            'تسجيل الخروج',
                            style: AppText.body.copyWith(
                              color: AppColors.primaryAction,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),

              // Bottom Navigation
              Container(
                height: 62,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: AppColors.cardBackgroundDeep,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    _buildNavItem(
                      icon: Icons.home_outlined,
                      title: 'الرئيسية',
                      selected: false,
                      onTap: () {
                        Navigator.pushAndRemoveUntil<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const HomeScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                    _buildNavItem(
                      icon: Icons.history,
                      title: 'السجل',
                      selected: false,
                      onTap: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const CompletedRequestsScreen(),
                          ),
                        );
                      },
                    ),
                    _buildNavItem(
                      icon: Icons.event_available_outlined,
                      title: 'حجوزاتي',
                      selected: false,
                      onTap: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const MyRequestsScreen(),
                          ),
                        );
                      },
                    ),
                    _buildNavItem(
                      icon: Icons.forum_outlined,
                      title: 'المحادثات',
                      selected: false,
                      onTap: () => _showUnavailable(context),
                    ),
                    _buildNavItem(
                      icon: Icons.person,
                      title: 'حسابي',
                      selected: true,
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../data/request_mapping.dart';
import '../../theme/app_theme.dart';
import '../auth/login_screen.dart';
import '../requests/mechanic_requests_screen.dart';
import '../requests/widgets/request_info_line_widget.dart';
import '../requests/widgets/status_badge_widget.dart';
import 'mechanic_profile_screen.dart';
import 'mechanic_requests_preview_screen.dart';

class MechanicDashboardScreen extends StatefulWidget {
  const MechanicDashboardScreen({super.key});

  @override
  State<MechanicDashboardScreen> createState() => _MechanicDashboardScreenState();
}

class _MechanicDashboardScreenState extends State<MechanicDashboardScreen> {
  String? get _phone => MockData.currentUser?['phone']?.toString();

  Map<String, dynamic>? get _workshop {
    final String? phone = _phone;
    if (phone == null || phone.isEmpty) {
      return null;
    }

    for (final Map<String, dynamic> workshop in MockData.mockMechanics) {
      if (workshop['phone']?.toString() == phone) {
        return workshop;
      }
    }
    return null;
  }

  List<Map<String, dynamic>> get _requests {
    final String? phone = _phone;
    if (phone == null || phone.isEmpty) {
      return <Map<String, dynamic>>[];
    }

    return MockData.mockRequests
        .where((Map<String, dynamic> request) {
          return request['mechanicPhone']?.toString() == phone;
        })
        .toList();
  }

  Future<void> _open(Widget screen) async {
    await Navigator.push<void>(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) => screen),
    );
    // الشاشات بتعدّل البيانات المشتركة، فبنعيد البناء بعد الرجوع
    if (mounted) {
      setState(() {});
    }
  }

  void _logout() {
    MockData.currentUser = null;
    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const LoginScreen(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? workshop = _workshop;
    final List<Map<String, dynamic>> requests = _requests;
    final List<Map<String, dynamic>> latest = List<Map<String, dynamic>>.of(
      requests,
    )..sort((Map<String, dynamic> a, Map<String, dynamic> b) {
        return (b['createdAt'] ?? '').toString().compareTo(
          (a['createdAt'] ?? '').toString(),
        );
      });
    final List<Map<String, dynamic>> recent = latest.take(3).toList();

    final int pending = requests
        .where((Map<String, dynamic> request) => request['status'] == 'pending')
        .length;
    final int accepted = requests
        .where((Map<String, dynamic> request) => request['status'] == 'accepted')
        .length;
    final int completed = requests
        .where((Map<String, dynamic> request) => request['status'] == 'completed')
        .length;

    final String name = MockData.currentUser?['name']?.toString() ?? '';

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('لوحة الميكانيكي'),
          actions: <Widget>[
            IconButton(
              onPressed: () => _open(const MechanicProfileScreen()),
              icon: const Icon(Icons.person_outline),
              tooltip: 'بيانات الورشة',
            ),
            IconButton(
              onPressed: _logout,
              icon: const Icon(Icons.logout),
              tooltip: 'تسجيل الخروج',
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(AppMetrics.gutter),
            children: <Widget>[
              Text(
                name.isEmpty ? 'أهلاً بيك' : 'أهلاً $name',
                style: AppText.screenTitle,
              ),
              const SizedBox(height: 16),
              if (workshop == null)
                _WorkshopPrompt(
                  onPressed: () => _open(const MechanicProfileScreen()),
                )
              else
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(AppMetrics.radius),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        workshop['workshopName']?.toString() ?? '',
                        style: AppText.cardTitle,
                      ),
                      const SizedBox(height: 8),
                      RequestInfoLine(
                        icon: Icons.home_repair_service_outlined,
                        text: workshop['specialty']?.toString() ?? '',
                      ),
                      const SizedBox(height: 6),
                      RequestInfoLine(
                        icon: Icons.location_on_outlined,
                        text: workshop['address']?.toString() ?? '',
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () => _open(const MechanicProfileScreen()),
                          child: const Text('تعديل البيانات'),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              Text('أعداد الطلبات', style: AppText.sectionTitle),
              const SizedBox(height: 11),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _CountCard(
                      label: 'جديدة',
                      count: pending,
                      color: AppColors.warningStatus,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _CountCard(
                      label: 'مقبولة',
                      count: accepted,
                      color: AppColors.primaryAction,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _CountCard(
                      label: 'مكتملة',
                      count: completed,
                      color: AppColors.successStatus,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Text('آخر الطلبات', style: AppText.sectionTitle),
                  const Spacer(),
                  IconButton(
                    onPressed: () => _open(const MechanicRequestsPreviewScreen()),
                    icon: const Icon(Icons.visibility_outlined, size: 20),
                    tooltip: 'معاينة الطلبات',
                  ),
                ],
              ),
              const SizedBox(height: 11),
              if (recent.isEmpty)
                Text(
                  'مفيش طلبات واردة لحد الآن',
                  style: AppText.body.copyWith(color: AppColors.textSecondary),
                )
              else
                ...recent.map(
                  (Map<String, dynamic> request) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  request['serviceType']?.toString() ?? '',
                                  style: AppText.cardTitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  request['createdAt']?.toString() ?? '',
                                  style: AppText.fieldLabel.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          RequestStatusBadge(
                            status: requestStatusFromValue(request['status']),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _open(const MechanicRequestsScreen()),
                child: const Text('عرض كل الطلبات'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkshopPrompt extends StatelessWidget {
  const _WorkshopPrompt({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppMetrics.radius),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(
                Icons.storefront_outlined,
                color: AppColors.primaryAction,
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  'لسه مضفتش بيانات ورشتك',
                  style: AppText.cardTitle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'أضف اسم الورشة والتخصص والعنوان عشان تظهر لأصحاب العربيات.',
            style: AppText.body.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: onPressed,
            child: const Text('إضافة بيانات الورشة'),
          ),
        ],
      ),
    );
  }
}

class _CountCard extends StatelessWidget {
  const _CountCard({
    required this.label,
    required this.count,
    required this.color,
  });

  final String label;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: <Widget>[
          Text('$count', style: AppText.screenTitle.copyWith(color: color)),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppText.fieldLabel.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

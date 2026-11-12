import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import 'my_requests_screen.dart';

class CreateRequestScreen extends StatefulWidget {
  const CreateRequestScreen({required this.mechanic, super.key});

  final Map<String, dynamic> mechanic;

  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _notesController = TextEditingController();

  Object? _selectedCarId;
  String? _selectedServiceType;

  static const List<String> _serviceTypes = <String>[
    'صيانة دورية',
    'تغيير زيت وفلاتر',
    'فحص فرامل',
    'كهرباء وتكييف',
    'عفشة ومساعدين',
    'فحص محرك',
    'أخرى',
  ];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _submitRequest() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (MockData.currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يجب تسجيل الدخول أولاً!')),
      );
      return;
    }

    // الحقول دي هي نفس أسماء عقد البيانات المشترك، عشان باقي الشاشات تقرأها
    final Map<String, dynamic> newRequest = <String, dynamic>{
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'ownerPhone': MockData.currentUser!['phone'],
      'carId': _selectedCarId,
      'mechanicPhone': widget.mechanic['phone'],
      'serviceType': _selectedServiceType,
      'notes': _notesController.text.trim(),
      'status': 'pending',
      'createdAt': DateTime.now().toString().split(' ')[0],
    };

    MockData.mockRequests.add(newRequest);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إرسال طلب الصيانة بنجاح!')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const MyRequestsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> userCars = MockData.mockCars
        .where((Map<String, dynamic> car) {
          return car['ownerPhone'] == MockData.currentUser?['phone'];
        })
        .toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('إنشاء طلب صيانة')),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppMetrics.gutter),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.build,
                          color: AppColors.primaryAction,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'الورشة: ${widget.mechanic['workshopName'] ?? ''}',
                                style: AppText.cardTitle,
                              ),
                              Text(
                                'التخصص: ${widget.mechanic['specialty'] ?? ''}',
                                style: AppText.body.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (userCars.isEmpty) ...<Widget>[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        children: <Widget>[
                          const Icon(
                            Icons.info_outline,
                            color: AppColors.warningStatus,
                            size: 36,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'لا توجد عربيات مسجلة في حسابك!',
                            style: AppText.cardTitle,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'يرجى الذهاب إلى شاشة عربياتي وإضافة عربية أولاً قبل إنشاء الطلب.',
                            textAlign: TextAlign.center,
                            style: AppText.body.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ] else ...<Widget>[
                    DropdownButtonFormField<Object>(
                      initialValue: _selectedCarId,
                      decoration: const InputDecoration(
                        labelText: 'اختر العربية *',
                        prefixIcon: Icon(Icons.directions_car),
                      ),
                      items: userCars.map((Map<String, dynamic> car) {
                        return DropdownMenuItem<Object>(
                          value: car['id'],
                          child: Text(
                            '${car['brand']} - ${car['year']} (${car['plate']})',
                          ),
                        );
                      }).toList(),
                      onChanged: (Object? value) {
                        setState(() {
                          _selectedCarId = value;
                        });
                      },
                      validator: (Object? value) {
                        if (value == null) {
                          return 'يرجى اختيار العربية';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                  DropdownButtonFormField<String>(
                    initialValue: _selectedServiceType,
                    decoration: const InputDecoration(
                      labelText: 'نوع الخدمة *',
                      prefixIcon: Icon(Icons.car_crash_outlined),
                    ),
                    items: _serviceTypes.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedServiceType = value;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى اختيار نوع الخدمة';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _notesController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'الملاحظات',
                      hintText: 'اكتب أي تفاصيل بخصوص العطل (اختياري)...',
                      alignLabelWithHint: true,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(bottom: 40),
                        child: Icon(Icons.notes),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: userCars.isEmpty ? null : _submitRequest,
                    child: const Text('إنشاء الطلب'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

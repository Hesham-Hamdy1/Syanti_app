import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';

class MechanicProfileScreen extends StatefulWidget {
  const MechanicProfileScreen({super.key});

  @override
  State<MechanicProfileScreen> createState() => _MechanicProfileScreenState();
}

class _MechanicProfileScreenState extends State<MechanicProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _workshopName;
  late final TextEditingController _specialty;
  late final TextEditingController _address;

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic>? workshop = _currentWorkshop();
    _workshopName = TextEditingController(
      text: workshop?['workshopName']?.toString() ?? '',
    );
    _specialty = TextEditingController(
      text: workshop?['specialty']?.toString() ?? '',
    );
    _address = TextEditingController(
      text: workshop?['address']?.toString() ?? '',
    );
  }

  /// الورشة مربوطة برقم هاتف الحساب الحالي، فلو الميكانيكي عدّل بياناته
  /// بنحدّث نفس العنصر بدل ما نضيف ورشة مكررة.
  Map<String, dynamic>? _currentWorkshop() {
    final String? phone = MockData.currentUser?['phone']?.toString();
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

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String? phone = MockData.currentUser?['phone']?.toString();
    if (phone == null || phone.isEmpty) {
      _showMessage('سجل الدخول الأول عشان نحفظ بيانات الورشة');
      return;
    }

    final Map<String, dynamic> data = <String, dynamic>{
      'phone': phone,
      'workshopName': _workshopName.text.trim(),
      'specialty': _specialty.text.trim(),
      'address': _address.text.trim(),
    };

    final Map<String, dynamic>? workshop = _currentWorkshop();
    if (workshop == null) {
      MockData.mockMechanics.add(data);
    } else {
      workshop.addAll(data);
    }

    _showMessage('تم حفظ بيانات الورشة');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _workshopName.dispose();
    _specialty.dispose();
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('بيانات الورشة')),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(AppMetrics.gutter),
              children: <Widget>[
                Text(
                  'البيانات دي بتظهر لصاحب العربية وهو بيختار ورشة.',
                  style: AppText.body.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _workshopName,
                  style: AppText.body,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'اسم الورشة'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'اكتب اسم الورشة';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _specialty,
                  style: AppText.body,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'التخصص'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'اكتب تخصص الورشة';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _address,
                  style: AppText.body,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(labelText: 'العنوان'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'اكتب عنوان الورشة';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppMetrics.gutter,
              8,
              AppMetrics.gutter,
              12,
            ),
            child: ElevatedButton(
              onPressed: _save,
              child: const Text('حفظ البيانات'),
            ),
          ),
        ),
      ),
    );
  }
}

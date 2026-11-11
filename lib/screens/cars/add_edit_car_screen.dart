import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';

class AddEditCarScreen extends StatefulWidget {
  final Map<String, dynamic>? car;
  const AddEditCarScreen({super.key, this.car});

  @override
  State<AddEditCarScreen> createState() => _AddEditCarScreenState();
}

class _AddEditCarScreenState extends State<AddEditCarScreen> {
  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _yearController = TextEditingController();
  final _plateController = TextEditingController();
  final _kmController = TextEditingController();

  bool get isEdit => widget.car != null;

  @override
  void initState() {
    super.initState();
    if (widget.car != null) {
      _brandController.text = '${widget.car!['brand']}';
      _yearController.text = '${widget.car!['year']}';
      _plateController.text = '${widget.car!['plate']}';
      _kmController.text = '${widget.car!['km']}';
    }
  }

  @override
  void dispose() {
    _brandController.dispose();
    _yearController.dispose();
    _plateController.dispose();
    _kmController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    
    final brand = _brandController.text.trim();
    // استخدمنا ! بعد المتغير لأننا واثقين إن الـ validator اتأكد إنها أرقام صحيحة
    final year = int.parse(_yearController.text.trim());
    final plate = _plateController.text.trim();
    final km = int.parse(_kmController.text.trim());

    if (!isEdit) {
      final phone = MockData.currentUser?['phone'];
      int maxId = 0;
      for (final c in MockData.mockCars) {
        if ((c['id'] as int) > maxId) maxId = c['id'] as int;
      }
      MockData.mockCars.add({
        'id': maxId + 1,
        'ownerPhone': phone,
        'brand': brand,
        'year': year,
        'plate': plate,
        'km': km,
      });
    } else {
      widget.car!['brand'] = brand;
      widget.car!['year'] = year;
      widget.car!['plate'] = plate;
      widget.car!['km'] = km;
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(isEdit ? 'تعديل عربية' : 'إضافة عربية', style: AppText.screenTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppMetrics.gutter),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('الماركة', style: AppText.body.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _brandController,
                  decoration: InputDecoration(
                    hintText: 'مثال: تويوتا كورولا',
                    filled: true,
                    fillColor: AppColors.cardBackground,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                  ),
                  validator: (val) => val == null || val.trim().isEmpty ? 'مطلوب' : null,
                ),
                
                const SizedBox(height: 16),
                
                Text('سنة الصنع', style: AppText.body.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _yearController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'مثال: 2022',
                    filled: true,
                    fillColor: AppColors.cardBackground,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                  ),
                  validator: (val) {
                    final year = int.tryParse(val?.trim() ?? '');
                    if (year == null) return 'اكتب السنة بالأرقام';
                    if (year < 1950 || year > DateTime.now().year + 1) return 'سنة غير منطقية';
                    return null;
                  },
                ),

                const SizedBox(height: 16),
                
                Text('رقم اللوحة', style: AppText.body.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _plateController,
                  decoration: InputDecoration(
                    hintText: 'مثال: أ ب ج 1234',
                    filled: true,
                    fillColor: AppColors.cardBackground,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                  ),
                  validator: (val) => val == null || val.trim().isEmpty ? 'مطلوب' : null,
                ),

                const SizedBox(height: 16),
                
                Text('الكيلومترات', style: AppText.body.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _kmController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'مثال: 45000',
                    filled: true,
                    fillColor: AppColors.cardBackground,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                  ),
                  validator: (val) {
                    final km = int.tryParse(val?.trim() ?? '');
                    if (km == null) return 'اكتب الكيلومترات بالأرقام';
                    if (km < 0) return 'لا يمكن إدخال رقم سالب';
                    return null;
                  },
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: AppMetrics.buttonHeight,
                  child: ElevatedButton(
                    onPressed: _save,
                    child: const Text('حفظ'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
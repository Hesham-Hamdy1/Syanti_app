# صيانتي (Syanti)

تطبيق لصيانة السيارات يربط بين أصحاب السيارات والميكانيكيين — مشروع مبادرة DEPI.

## الحالة الحالية

مشروع فاضي (Empty Project) — لم يبدأ التنفيذ بعد. سيتم إضافة الـ MVP حسب خطة الفريق.

## المتطلبات

- Flutter 3.x
- Firebase (Auth + Firestore)

## التشغيل

```bash
flutter pub get
flutter run
```

## هيكل الـ MVP المخطط

- `auth/` — تسجيل الدخول وإنشاء الحساب ونوع المستخدم (Firebase Auth + `users/{uid}`)
- `cars/` — عربيات صاحب العربية (إضافة/تعديل/حذف/تفاصيل)
- `mechanic/` — بيانات الورشة و Dashboard الميكانيكي
- `requests_owner/` — إنشاء طلب الصيانة من صاحب العربية
- `requests_flow/` — متابعة الطلبات وتغيير حالتها (pending → accepted → completed)
- `maintenance_records/` — سجل الصيانة + الثيم + الراوتر
- `core/` — الألوان، الخطوط، الثيم، `app_router.dart`

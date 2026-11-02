import 'package:flutter/material.dart';

/// ألوان التطبيق مأخوذة من ملف فيجما، والتعليق فوق كل لون بيقول أماكن استخدامه
/// الحقيقية وعدد مراتها في التصميم. أي لون جديد يتضاف هنا مش في الشاشة.
class AppColors {
  /// خلفية الشاشات نفسها، وهي الأكثر استخداماً في التصميم كله
  /// وبتتستخدم كمان في خطوط فاصلة غامقة
  static const Color scaffoldBackground = Color(0xFF000000);

  /// خلفية الكروت والأقسام المرتفعة جوه الشاشات
  static const Color cardBackground = Color(0xFF151C23);

  /// خلفية أغمق للكروت، ظاهرة في الرئيسية وشاشة الحساب
  static const Color cardBackgroundDeep = Color(0xFF080D12);

  /// خلفية حقول الإدخال في شاشات الدخول والتحقق وكلمة المرور
  static const Color fieldBackground = Color(0xFF1A1A1A);

  /// الحدود والفواصل، وبيتستخدم كمان كنص باهت في شاشة الدفع
  static const Color border = Color(0xFF303943);

  /// البرتقالي الأساسي: أزرار وأيقونات ونصوص في أغلب الشاشات
  static const Color primaryAction = Color(0xFFFF6633);

  /// درجة أغمق من البرتقالي، مستخدمة في شاشتي الدخول والتحقق بس
  static const Color primaryActionDark = Color(0xFFFF6B00);

  /// برتقالي فاتح للتدرجات وأيقونات الرئيسية
  static const Color primaryActionSoft = Color(0xFFFF8A5B);

  /// النص الأساسي في التطبيق كله، وهو الأكثر استخداماً كنص
  static const Color textPrimary = Color(0xFFFFFFFF);

  /// الأيقونات والخطوط الفاتحة
  static const Color iconLight = Color(0xFFF5F5F5);

  /// النص الثانوي والأيقونات الباهتة والحدود الرمادية
  static const Color textSecondary = Color(0xFFA3ADB7);

  /// خلفية الزر الفاتح في شاشة الترحيب والخلفيات الخفيفة
  static const Color lightButtonBackground = Color(0xFFF2F2F7);

  /// خلفية مؤقتة مكان الصور، وبيتستخدم كمان خلفية تسميات صغيرة في الدخول
  static const Color placeholderGray = Color(0xFFD9D9D9);

  /// أزرق فاتح للأيقونات في شاشات الدخول والتحقق
  static const Color accentLight = Color(0xFFEFF6FF);

  /// حدود وأيقونات الحالة الناجحة، زي خطوات الطلب المكتملة
  static const Color successStatus = Color(0xFF55C98A);

  /// التحذير ونجوم التقييم
  static const Color warningStatus = Color(0xFFFFCC00);
}

/// أحجام الخطوط زي ما هي في فيجما، وارتفاع السطر ثابت في كل الأحجام 1.303.
/// الفريق يستخدم الاسم الجاهز هنا، مش رقم مكتوب في الشاشة.
class AppText {
  static const String family = 'HankenGrotesk';
  static const double lineHeight = 1.303;

  /// عنوان الشاشة في الشريط العلوي
  static final TextStyle screenTitle = _style(20, FontWeight.w800);

  /// نص الأزرار الكبيرة زي أبدا والدخول والتالي
  static final TextStyle button = _style(20, FontWeight.w700);

  /// عنوان قسم جوه الشاشة زي خدمات الصيانة ومحتوى الخدمة
  static final TextStyle sectionTitle = _style(16, FontWeight.w800);

  /// عنوان كارت أو عنصر في قائمة
  static final TextStyle cardTitle = _style(14, FontWeight.w800);

  /// نص عادي في الشرح والوصف
  static final TextStyle body = _style(12, FontWeight.w700);

  /// تسمية صغيرة فوق حقل الإدخال
  static final TextStyle fieldLabel = _style(10, FontWeight.w700);

  /// تسمية أيقونة شريط التنقل السفلي
  static final TextStyle navLabel = _style(11, FontWeight.w800);

  static TextStyle _style(double size, FontWeight weight) {
    return TextStyle(
      fontFamily: family,
      fontWeight: weight,
      fontSize: size,
      height: lineHeight,
      color: AppColors.textPrimary,
    );
  }
}

/// مقاسات إطار التصميم والقيم المتكررة، عشان الأرقام تبقى في مكان واحد
class AppMetrics {
  /// عرض وطول الشاشة اللي اترسم عليها التصميم في فيجما
  static const double designWidth = 430.0;
  static const double designHeight = 932.0;

  /// المسافة الجانبية بين المحتوى وحواف الشاشة
  static const double gutter = 17.0;

  /// ارتفاع حقل الإدخال
  static const double fieldHeight = 37.0;

  /// ارتفاع الزر الأساسي
  static const double buttonHeight = 49.0;

  /// استدارة الحقول والأزرار والكروت
  static const double radius = 15.0;
}

class AppTheme {
  static ThemeData get dark {
    final ThemeData base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.primaryAction,
        surface: AppColors.cardBackground,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: base.textTheme.apply(
        fontFamily: AppText.family,
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      // الشريط العلوي متظبط مرة واحدة، فالفريق ميعيدش تنسيقه في كل شاشة
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.scaffoldBackground,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppText.screenTitle,
      ),
      // شكل الحقول موحد، فأي TextField جديد يطلع بنفس الشكل من غير كود زيادة
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.fieldBackground,
        hintStyle: AppText.body.copyWith(color: AppColors.textSecondary),
        labelStyle: AppText.fieldLabel.copyWith(color: AppColors.textSecondary),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppMetrics.radius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppMetrics.radius),
          borderSide: const BorderSide(color: AppColors.primaryAction),
        ),
      ),
      // كل الأزرار الأساسية بنفس اللون والارتفاع والاستدارة
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryAction,
          foregroundColor: AppColors.textPrimary,
          minimumSize: const Size.fromHeight(AppMetrics.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppMetrics.radius),
          ),
          textStyle: AppText.button,
        ),
      ),
    );
  }
}

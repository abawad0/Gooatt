# قوّت — Qawwat Flutter App

تطبيق ذكي لاكتشاف الأطعمة وتقييم الأطباق.

## البدء السريع

```bash
flutter pub get
flutter run
```

## ما يجب فعله قبل التشغيل

1. **الخطوط**: حمّل خطوط Tajawal من [Google Fonts](https://fonts.google.com/specimen/Tajawal)
   وضعها في `assets/fonts/` (Regular, Medium, Bold).

2. **Supabase**: أنشئ مشروع على [supabase.com](https://supabase.com)، ثم في `lib/core/supabase_client.dart`:
   ```dart
   await Supabase.initialize(
     url: 'YOUR_SUPABASE_URL',
     anonKey: 'YOUR_ANON_KEY',
   );
   ```

3. **Google Maps**: أضف مفتاح API في:
   - `android/app/src/main/AndroidManifest.xml`
   - `ios/Runner/AppDelegate.swift`

4. **Firebase**: شغّل `flutterfire configure` لربط Firebase Cloud Messaging.

5. **RTL الكامل**: أضف لـ `pubspec.yaml` (موجود مسبقاً) ولـ `main.dart`:
   ```dart
   localizationsDelegates: const [
     GlobalMaterialLocalizations.delegate,
     GlobalWidgetsLocalizations.delegate,
     GlobalCupertinoLocalizations.delegate,
   ],
   ```
   (يتطلب `import 'package:flutter_localizations/flutter_localizations.dart';`)

## هيكل المشروع

```
lib/
  ├── main.dart                      نقطة الدخول
  ├── core/
  │   └── theme.dart                 الألوان والخطوط والثيم
  ├── models/
  │   └── models.dart                Dish, Rating, UserProfile, FoodCategory
  ├── screens/
  │   ├── home_screen.dart           الرئيسية
  │   ├── detail_screens.dart        تفاصيل الطبق + مزاجك اليوم + كم معك؟
  │   ├── add_review_screen.dart     إضافة تقييم
  │   ├── legend_screen.dart         الطبق الأسطوري
  │   └── profile_pro_screens.dart   الملف الشخصي + الاشتراك المميز
  └── widgets/
      └── dish_card.dart             DishCard, TrendItem
```

## ملاحظات مهمة

- جميع البيانات في الشاشات حالياً **بيانات تجريبية ثابتة** (sample/mock data).
  استبدلها باستعلامات Supabase الفعلية — أماكن التعليق `// TODO:` تشير لذلك.
- معادلة حساب التقييم الإجمالي موجودة في `models.dart`:
  `score = taste×0.40 + value×0.30 + cleanliness×0.15 + speed×0.15`
- شاشة Food Radar لم تُضمّن بعد في كود Flutter (موجودة فقط في الموكب التفاعلي) —
  راجع وثيقة المواصفات (`qawwat_spec.docx`) للتفاصيل قبل بنائها بـ Google Maps SDK.

## المرجع الكامل

راجع `qawwat_spec.docx` لتفاصيل كل شاشة، هيكل قاعدة البيانات، ونموذج الإيرادات.

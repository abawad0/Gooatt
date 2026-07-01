import 'package:flutter/material.dart';
import '../core/theme.dart';

// ═══════════════════════════════════════════════════════════════
// PROFILE SCREEN
// ═══════════════════════════════════════════════════════════════
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('قوّت', style: TextStyle(fontFamily: 'Tajawal')),
          actions: [
            IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () {}),
            IconButton(icon: const Icon(Icons.ios_share), onPressed: () {}),
          ],
        ),
        body: ListView(children: [
          Container(
            width: double.infinity,
            color: QawwatTheme.primary,
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
            child: Column(children: [
              Container(
                width: 72, height: 72,
                decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.4), width: 3)),
                child: const Center(child: Text('👨‍🍳', style: TextStyle(fontSize: 28))),
              ),
              const SizedBox(height: 10),
              const Text('فهد العتيبي', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'Tajawal')),
              const SizedBox(height: 3),
              Text('📍 الرياض · عضو منذ 2024', style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.8), fontFamily: 'Tajawal')),
            ]),
          ),
          Transform.translate(
            offset: const Offset(0, -18),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(children: [
                Expanded(child: _statBox('47', 'تقييم', isLeft: true)),
                Expanded(child: _statBox('12', 'مدينة')),
                Expanded(child: _statBox('3', 'أسطوري', isRight: true)),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(color: QawwatTheme.amber, borderRadius: BorderRadius.circular(12), border: Border.all(color: QawwatTheme.amberBorder, width: 0.5)),
              child: Row(children: const [
                Text('🏅', style: TextStyle(fontSize: 20)),
                SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('ذواقة محترف', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF633806), fontFamily: 'Tajawal')),
                  Text('قيّم 47 طبق من 8 تصنيفات مختلفة', style: TextStyle(fontSize: 11, color: Color(0xFF854F0B), fontFamily: 'Tajawal')),
                ])),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('أفضل اختياراته', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Tajawal')),
              Text('الكل', style: TextStyle(fontSize: 11, color: QawwatTheme.primary, fontFamily: 'Tajawal')),
            ]),
          ),
          ..._buildPicks(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: const Text('إحصائياتي الغذائية', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Tajawal')),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.6,
              children: const [
                _StatTile(value: 'شاورما', label: 'الأكثر تقييماً'),
                _StatTile(value: '8.7', label: 'متوسط تقييماتك'),
                _StatTile(value: '35 ر.س', label: 'متوسط ميزانيتك'),
                _StatTile(value: '5', label: 'أطباق أسطورية'),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }

  Widget _statBox(String value, String label, {bool isLeft = false, bool isRight = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEAE8E4), width: 0.5),
        borderRadius: BorderRadius.horizontal(
          right: isLeft ? const Radius.circular(12) : Radius.zero,
          left: isRight ? const Radius.circular(12) : Radius.zero,
        ),
      ),
      child: Column(children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFFC84B2F), fontFamily: 'Tajawal')),
        Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF888888), fontFamily: 'Tajawal')),
      ]),
    );
  }

  List<Widget> _buildPicks() {
    final picks = [
      ('🌯', 'شاورما دجاج — الأمير', '9.5 · النخيل، الرياض'),
      ('🍔', 'سموكي برغر — The Butcher', '9.1 · السليمانية'),
      ('☕', 'لاتيه تمر — Boon', '9.0 · العليا'),
    ];
    return picks.map((p) => Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFEAE8E4), width: 0.5)),
        child: Row(children: [
          Text(p.$1, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 10),
          Expanded(child: Text(p.$2, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Tajawal'))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: const Color(0xFFFFF1EC), borderRadius: BorderRadius.circular(10)),
            child: Text('★ ${p.$3.split(' ').first}', style: const TextStyle(fontSize: 11, color: Color(0xFF993C1D), fontFamily: 'Tajawal')),
          ),
        ]),
      ),
    )).toList();
  }
}

class _StatTile extends StatelessWidget {
  final String value, label;
  const _StatTile({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFF8F6F3), borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFFC84B2F), fontFamily: 'Tajawal')),
          Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF888888), fontFamily: 'Tajawal')),
        ]),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// PRO SUBSCRIPTION SCREEN
// ═══════════════════════════════════════════════════════════════
class ProScreen extends StatefulWidget {
  const ProScreen({super.key});

  @override
  State<ProScreen> createState() => _ProScreenState();
}

class _ProScreenState extends State<ProScreen> {
  int _selectedPlan = 1; // 0 = monthly, 1 = yearly

  static const _features = [
    (Icons.block, 'بدون إعلانات'),
    (Icons.psychology_outlined, 'توصيات ذكية متقدمة'),
    (Icons.groups_outlined, 'مجموعات توصيات خاصة'),
    (Icons.pie_chart_outline, 'إحصائياتك الغذائية'),
    (Icons.emoji_events_outlined, 'ترشيح طبق الأسبوع'),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('قوّت Pro ✨', style: TextStyle(fontFamily: 'Tajawal')),
          backgroundColor: QawwatTheme.purple,
        ),
        body: ListView(children: [
          Container(
            width: double.infinity,
            color: QawwatTheme.purple,
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(children: const [
              Text('👑', style: TextStyle(fontSize: 32)),
              SizedBox(height: 8),
              Text('قوّت المميز', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'Tajawal')),
              SizedBox(height: 6),
              Text('تجربة غذائية أذكى وأكثر تخصيصاً', style: TextStyle(fontSize: 13, color: Colors.white70, fontFamily: 'Tajawal')),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              Row(children: [
                Expanded(child: _planCard('شهري', '19', 'ر.س / شهر', 0)),
                const SizedBox(width: 10),
                Expanded(child: _planCard('سنوي', '149', 'ر.س / سنة', 1, badge: 'الأوفر')),
              ]),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFEAE8E4), width: 0.5)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('ما يشمله الاشتراك', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, fontFamily: 'Tajawal')),
                  const SizedBox(height: 12),
                  ..._features.map((f) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(children: [
                      Icon(f.$1, color: QawwatTheme.purple, size: 18),
                      const SizedBox(width: 10),
                      Text(f.$2, style: const TextStyle(fontSize: 13, fontFamily: 'Tajawal')),
                    ]),
                  )),
                ]),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: QawwatTheme.purple, padding: const EdgeInsets.symmetric(vertical: 14)),
                  onPressed: () {},
                  child: const Text('ابدأ تجربة مجانية 7 أيام', style: TextStyle(fontFamily: 'Tajawal', fontSize: 15)),
                ),
              ),
              const SizedBox(height: 10),
              const Text('لا يلزم بطاقة الآن · إلغاء في أي وقت', style: TextStyle(fontSize: 11, color: Color(0xFFAAAAAA), fontFamily: 'Tajawal')),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _planCard(String period, String price, String unit, int index, {String? badge}) {
    final selected = _selectedPlan == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedPlan = index),
      child: Stack(clipBehavior: Clip.none, children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: selected ? QawwatTheme.purple : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: selected ? QawwatTheme.purple : const Color(0xFFEAE8E4), width: selected ? 2 : 0.5),
          ),
          child: Column(children: [
            Text(period, style: TextStyle(fontSize: 11, color: selected ? Colors.white70 : const Color(0xFF888888), fontFamily: 'Tajawal')),
            const SizedBox(height: 4),
            Text(price, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: selected ? Colors.white : QawwatTheme.purple, fontFamily: 'Tajawal')),
            Text(unit, style: TextStyle(fontSize: 11, color: selected ? Colors.white70 : const Color(0xFF888888), fontFamily: 'Tajawal')),
          ]),
        ),
        if (badge != null)
          Positioned(
            top: -8, right: 0, left: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: QawwatTheme.amberBorder, borderRadius: BorderRadius.circular(8)),
                child: const Text('الأوفر', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF412402), fontFamily: 'Tajawal')),
              ),
            ),
          ),
      ]),
    );
  }
}

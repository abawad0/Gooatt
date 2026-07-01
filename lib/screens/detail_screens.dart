import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../models/models.dart';

// ═══════════════════════════════════════════════════════════════
// DISH DETAIL SCREEN
// ═══════════════════════════════════════════════════════════════
class DishDetailScreen extends StatelessWidget {
  final Dish dish;
  const DishDetailScreen({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              backgroundColor: QawwatTheme.primary,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: QawwatTheme.dishBg,
                  child: Center(child: Text(dish.emoji, style: const TextStyle(fontSize: 80))),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(children: [
                Text(dish.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'Tajawal')),
                const SizedBox(height: 4),
                Text('🏪 ${dish.restaurantName} · ${dish.district}', style: const TextStyle(fontSize: 13, color: Color(0xFF888888), fontFamily: 'Tajawal')),
                const SizedBox(height: 14),
                _buildRatingSection(),
                const SizedBox(height: 12),
                _buildBadges(),
                const SizedBox(height: 16),
                _buildReviews(),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.local_shipping_outlined),
                    label: const Text('اطلب الآن عبر حنقرستيشن', style: TextStyle(fontFamily: 'Tajawal')),
                  ),
                ),
              ].map((w) => SliverToBoxAdapter(child: w)).toList()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingSection() {
    return Row(children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(color: QawwatTheme.primary, borderRadius: BorderRadius.circular(10)),
        child: Text(dish.score.toStringAsFixed(1), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white, fontFamily: 'Tajawal')),
      ),
      const SizedBox(width: 14),
      Expanded(
        child: Column(children: [
          _ratingBar('الطعم', 0.95),
          const SizedBox(height: 4),
          _ratingBar('القيمة', 0.90),
          const SizedBox(height: 4),
          _ratingBar('الخدمة', 0.88),
        ]),
      ),
    ]);
  }

  Widget _ratingBar(String label, double val) {
    return Row(children: [
      SizedBox(width: 60, child: Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF888888), fontFamily: 'Tajawal'))),
      Expanded(child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: LinearProgressIndicator(value: val, backgroundColor: const Color(0xFFEAE8E4), color: QawwatTheme.primary, minHeight: 4),
      )),
      const SizedBox(width: 6),
      Text((val * 10).toStringAsFixed(1), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFFC84B2F), fontFamily: 'Tajawal')),
    ]);
  }

  Widget _buildBadges() {
    return Wrap(spacing: 8, children: [
      _badge('💰 ${dish.price.toInt()} ر.س', const Color(0xFFFFF1EC), const Color(0xFF993C1D)),
      _badge('⏱ 5-10 دقائق', const Color(0xFFEAF5F0), const Color(0xFF085041)),
      if (dish.isLegendary) _badge('🏅 طبق أسطوري', const Color(0xFFF0EDFF), const Color(0xFF5542C0)),
    ]);
  }

  Widget _badge(String text, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
      child: Text(text, style: TextStyle(fontSize: 11, color: textColor, fontFamily: 'Tajawal')),
    );
  }

  Widget _buildReviews() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('تقييمات المستخدمين', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Tajawal')),
      const SizedBox(height: 10),
      _reviewCard('محمد الغامدي', '★★★★★', 'من أفضل شاورما جربتها في الرياض! التوم رهيب والدجاج طري جداً.'),
      const SizedBox(height: 8),
      _reviewCard('سارة العتيبي', '★★★★☆', 'ممتازة! أفضل من الفروع الثانية. الخدمة سريعة والمكان نظيف.'),
    ]);
  }

  Widget _reviewCard(String user, String stars, String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFF8F6F3), borderRadius: BorderRadius.circular(10)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('🧑 $user · $stars', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Tajawal')),
        const SizedBox(height: 5),
        Text(text, style: const TextStyle(fontSize: 12, color: Color(0xFF666666), fontFamily: 'Tajawal', height: 1.5)),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// MOOD PICKER SCREEN
// ═══════════════════════════════════════════════════════════════
class MoodPickerScreen extends StatefulWidget {
  const MoodPickerScreen({super.key});

  @override
  State<MoodPickerScreen> createState() => _MoodPickerScreenState();
}

class _MoodPickerScreenState extends State<MoodPickerScreen> {
  bool _showResults = false;

  static const _moods = [
    ('🥗', 'خفيف وصحي'), ('🍔', 'ثقيل وشبعة'),
    ('⚡', 'سريع وسهل'), ('✨', 'فاخر'),
    ('💸', 'اقتصادي'), ('🎲', 'فاجئني'),
  ];

  static final _suggestions = [
    Dish(id:'1', name:'شاورما دجاج', restaurantName:'شاورما الأمير', district:'النخيل', city:'الرياض', category:'shawarma', price:18, score:9.2, reviewCount:347, emoji:'🌯'),
    Dish(id:'4', name:'سلطة فتوش', restaurantName:'سيدر', district:'العليا', city:'الرياض', category:'healthy', price:22, score:8.6, reviewCount:98, emoji:'🥗'),
    Dish(id:'5', name:'أفوكادو توست', restaurantName:"Barn's", district:'السليمانية', city:'الرياض', category:'breakfast', price:28, score:8.4, reviewCount:134, emoji:'🥑'),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('مزاجك اليوم', style: TextStyle(fontFamily: 'Tajawal'))),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('اختر مزاجك وخلنا نختار لك', style: TextStyle(fontSize: 13, color: Color(0xFF888888), fontFamily: 'Tajawal')),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.6,
                children: _moods.map((m) => _MoodCard(emoji: m.$1, label: m.$2, onTap: () => setState(() => _showResults = true))).toList(),
              ),
            ),
            if (_showResults) ...[
              const SizedBox(height: 16),
              const Text('🎯 أفضل 3 اقتراحات لك', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Tajawal')),
              const SizedBox(height: 10),
              ..._suggestions.map((d) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFEAE8E4), width: 0.5)),
                  child: Row(children: [
                    Text(d.emoji, style: const TextStyle(fontSize: 24)),
                    const SizedBox(width: 10),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(d.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, fontFamily: 'Tajawal')),
                      Text('${d.restaurantName} · ${d.price.toInt()} ر.س · ★ ${d.score}', style: const TextStyle(fontSize: 11, color: Color(0xFF888888), fontFamily: 'Tajawal')),
                    ])),
                  ]),
                ),
              )),
            ],
          ]),
        ),
      ),
    );
  }
}

class _MoodCard extends StatelessWidget {
  final String emoji, label;
  final VoidCallback onTap;
  const _MoodCard({required this.emoji, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFEAE8E4), width: 0.5),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Tajawal'), textAlign: TextAlign.center),
        ]),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// BUDGET SCREEN
// ═══════════════════════════════════════════════════════════════
class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  double _budget = 50;
  double _persons = 1;

  double get _perPerson => (_budget / _persons).roundToDouble();

  static final _suggestions = [
    (Dish(id:'1', name:'شاورما دجاج', restaurantName:'شاورما الأمير', district:'', city:'', category:'shawarma', price:18, score:9.2, reviewCount:347, emoji:'🌯'), 'قيمة ممتازة'),
    (Dish(id:'6', name:'فول ومدمس', restaurantName:'بيت الفول', district:'', city:'', category:'popular', price:12, score:8.3, reviewCount:210, emoji:'🍳'), 'الأرخص'),
    (Dish(id:'7', name:'ساندويش تونة', restaurantName:'ساندويش هاوس', district:'', city:'', category:'popular', price:25, score:8.8, reviewCount:95, emoji:'🥪'), 'الأعلى تقييماً'),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('كم معك؟', style: TextStyle(fontFamily: 'Tajawal'))),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('حدد ميزانيتك وعدد الأشخاص', style: TextStyle(fontSize: 13, color: Color(0xFF888888), fontFamily: 'Tajawal')),
            const SizedBox(height: 20),
            _sliderSection('الميزانية', '${_budget.toInt()} ر.س', _budget, 20, 300, 5, (v) => setState(() => _budget = v)),
            const SizedBox(height: 14),
            _sliderSection('عدد الأشخاص', '${_persons.toInt()}', _persons, 1, 8, 1, (v) => setState(() => _persons = v)),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFEAE8E4), width: 0.5)),
              child: Column(children: [
                const Text('للشخص الواحد', style: TextStyle(fontSize: 12, color: Color(0xFF888888), fontFamily: 'Tajawal')),
                Text('${_perPerson.toInt()} ر.س', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFFC84B2F), fontFamily: 'Tajawal')),
              ]),
            ),
            const SizedBox(height: 16),
            const Text('🏅 أفضل قيمة ضمن ميزانيتك', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Tajawal')),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(children: _suggestions.map((s) {
                final dish = s.$1;
                final badge = s.$2;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFEAE8E4), width: 0.5)),
                    child: Row(children: [
                      Text(dish.emoji, style: const TextStyle(fontSize: 24)),
                      const SizedBox(width: 10),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(dish.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, fontFamily: 'Tajawal')),
                        Text('${dish.restaurantName} · ${dish.price.toInt()} ر.س', style: const TextStyle(fontSize: 11, color: Color(0xFF888888), fontFamily: 'Tajawal')),
                      ])),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: const Color(0xFFFFF1EC), borderRadius: BorderRadius.circular(10)),
                        child: Text(badge, style: const TextStyle(fontSize: 10, color: Color(0xFF993C1D), fontWeight: FontWeight.w700, fontFamily: 'Tajawal')),
                      ),
                    ]),
                  ),
                );
              }).toList()),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _sliderSection(String label, String value, double current, double min, double max, double step, ValueChanged<double> onChanged) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF666666), fontFamily: 'Tajawal')),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFFC84B2F), fontFamily: 'Tajawal')),
      ]),
      SliderTheme(
        data: SliderTheme.of(context).copyWith(activeTrackColor: QawwatTheme.primary, thumbColor: QawwatTheme.primary, inactiveTrackColor: const Color(0xFFEAE8E4)),
        child: Slider(value: current, min: min, max: max, divisions: ((max - min) / step).toInt(), onChanged: onChanged),
      ),
    ]);
  }
}

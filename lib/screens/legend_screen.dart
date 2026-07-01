import 'package:flutter/material.dart';
import '../core/theme.dart';

class LegendScreen extends StatefulWidget {
  const LegendScreen({super.key});

  @override
  State<LegendScreen> createState() => _LegendScreenState();
}

class _LegendScreenState extends State<LegendScreen> {
  int _cityIndex = 0;
  static const _cities = ['الرياض', 'جدة', 'الدمام'];

  static const _legends = [
    ('🌯', 'شاورما الأمير', 'شاورما دجاج · النخيل، الرياض', 9.4, 347, 9.7, 9.2, 9.1),
    ('🍔', 'The Butcher', 'سموكي برغر · السليمانية، الرياض', 9.1, 218, 9.3, 8.8, 9.0),
    ('☕', 'Boon Coffee', 'لاتيه تمر · العليا، الرياض', 9.0, 156, 9.2, 8.9, 8.8),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('🏆 الطبق الأسطوري', style: TextStyle(fontFamily: 'Tajawal'))),
        body: ListView(children: [
          Container(
            color: QawwatTheme.primary,
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('أطباق تجاوزت 9/10 بأكثر من 100 تقييم', style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.85), fontFamily: 'Tajawal')),
              const SizedBox(height: 8),
              Row(children: List.generate(_cities.length, (i) {
                final selected = _cityIndex == i;
                return Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: GestureDetector(
                    onTap: () => setState(() => _cityIndex = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(selected ? 0.3 : 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(_cities[i], style: const TextStyle(fontSize: 11, color: Colors.white, fontFamily: 'Tajawal')),
                    ),
                  ),
                );
              })),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: _legends.map((l) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFEAE8E4), width: 0.5),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(children: [
                  Container(
                    color: QawwatTheme.amber,
                    padding: const EdgeInsets.all(14),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(l.$1, style: const TextStyle(fontSize: 40)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(children: [
                            Text(l.$2, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Tajawal')),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(color: QawwatTheme.amberBorder, borderRadius: BorderRadius.circular(8)),
                              child: const Text('أسطوري', style: TextStyle(fontSize: 10, color: Color(0xFF412402), fontWeight: FontWeight.w700, fontFamily: 'Tajawal')),
                            ),
                          ]),
                          const SizedBox(height: 2),
                          Text(l.$3, style: const TextStyle(fontSize: 11, color: Color(0xFF888888), fontFamily: 'Tajawal')),
                          const SizedBox(height: 6),
                          Row(children: [
                            Text(l.$4.toString(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: QawwatTheme.primary, fontFamily: 'Tajawal')),
                            const SizedBox(width: 8),
                            Text('من 10\n${l.$5} تقييم', style: const TextStyle(fontSize: 11, color: Color(0xFF888888), fontFamily: 'Tajawal')),
                          ]),
                        ]),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(children: [
                      Expanded(child: _scoreCol('الطعم', l.$6)),
                      Container(width: 0.5, height: 30, color: const Color(0xFFEAE8E4)),
                      Expanded(child: _scoreCol('القيمة', l.$7)),
                      Container(width: 0.5, height: 30, color: const Color(0xFFEAE8E4)),
                      Expanded(child: _scoreCol('الخدمة', l.$8)),
                    ]),
                  ),
                ]),
              ),
            )).toList()),
          ),
        ]),
      ),
    );
  }

  Widget _scoreCol(String label, double value) {
    return Column(children: [
      Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF888888), fontFamily: 'Tajawal')),
      Text(value.toString(), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: QawwatTheme.primary, fontFamily: 'Tajawal')),
    ]);
  }
}

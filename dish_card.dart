import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../models/models.dart';
import '../widgets/dish_card.dart';
import 'detail_screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  int _navIndex = 0;

  // Sample data — replace with Supabase queries
  static const _weekDishes = [
    Dish(id:'1', name:'شاورما دجاج', restaurantName:'شاورما الأمير', district:'النخيل', city:'الرياض', category:'shawarma', price:18, score:9.2, reviewCount:347, emoji:'🌯', isLegendary:true),
    Dish(id:'2', name:'سموكي برغر', restaurantName:'The Butcher', district:'السليمانية', city:'الرياض', category:'burger', price:42, score:8.9, reviewCount:218, emoji:'🍔'),
    Dish(id:'3', name:'بيتزا مارغريتا', restaurantName:'Toscana', district:'العليا', city:'الرياض', category:'pizza', price:55, score:8.7, reviewCount:156, emoji:'🍕'),
  ];

  static const _trendingDishes = [
    Dish(id:'1', name:'شاورما لحم بالتوم', restaurantName:'مطعم الشام', district:'النخيل', city:'الرياض', category:'shawarma', price:22, score:9.0, reviewCount:312, emoji:'🌯'),
    Dish(id:'4', name:'لاتيه الكراميل', restaurantName:'ستاربكس', district:'العليا', city:'الرياض', category:'coffee', price:28, score:8.5, reviewCount:201, emoji:'☕'),
    Dish(id:'5', name:'بان كيك بالتوت', restaurantName:'Kitch', district:'السليمانية', city:'الرياض', category:'breakfast', price:35, score:8.4, reviewCount:179, emoji:'🥞'),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            _buildHeroSection(),
            SliverToBoxAdapter(child: _buildActionButtons()),
            SliverToBoxAdapter(child: _buildCategories()),
            SliverToBoxAdapter(child: _buildWeekDishes()),
            SliverToBoxAdapter(child: _buildTrending()),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
        bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }

  Widget _buildHeroSection() {
    return SliverAppBar(
      expandedHeight: 140,
      pinned: true,
      backgroundColor: QawwatTheme.primary,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: QawwatTheme.primary,
          padding: const EdgeInsets.fromLTRB(16, 50, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Icon(Icons.location_on, color: Colors.white70, size: 14),
                const SizedBox(width: 4),
                Text('الرياض، حي النخيل', style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12, fontFamily: 'Tajawal')),
              ]),
              const SizedBox(height: 6),
              const Text('وش تاكل اليوم؟', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700, fontFamily: 'Tajawal')),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: const Row(children: [
                  Icon(Icons.search, color: Colors.white70, size: 18),
                  SizedBox(width: 8),
                  Text('ابحث عن طبق أو مطعم...', style: TextStyle(color: Colors.white70, fontSize: 13, fontFamily: 'Tajawal')),
                ]),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(icon: const Icon(Icons.notifications_outlined, color: Colors.white), onPressed: () {}),
        IconButton(icon: const Icon(Icons.person_outline, color: Colors.white), onPressed: () {}),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(children: [
        Expanded(child: _ActionBtn(
          emoji: '🎲', label: 'ماذا آكل الآن؟', subtitle: 'اقتراح فوري',
          bgColor: const Color(0xFFFFF1EC), borderColor: const Color(0xFFF4B399),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MoodPickerScreen())),
        )),
        const SizedBox(width: 10),
        Expanded(child: _ActionBtn(
          emoji: '💰', label: 'كم معك؟', subtitle: 'ضمن ميزانيتك',
          bgColor: const Color(0xFFEAF5F0), borderColor: const Color(0xFF8FCFB3),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BudgetScreen())),
        )),
      ]),
    );
  }

  Widget _buildCategories() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('التصنيفات', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Tajawal')),
          Text('الكل', style: TextStyle(fontSize: 12, color: QawwatTheme.primary, fontFamily: 'Tajawal')),
        ]),
      ),
      SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: FoodCategory.all.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, i) {
            final cat = FoodCategory.all[i];
            final selected = _selectedCategoryIndex == i;
            return GestureDetector(
              onTap: () => setState(() => _selectedCategoryIndex = i),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: selected ? QawwatTheme.primary : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: selected ? QawwatTheme.primary : const Color(0xFFEAE8E4), width: 0.5),
                ),
                child: Text('${cat.emoji} ${cat.nameAr}',
                  style: TextStyle(fontSize: 12, color: selected ? Colors.white : const Color(0xFF666666), fontFamily: 'Tajawal')),
              ),
            );
          },
        ),
      ),
    ]);
  }

  Widget _buildWeekDishes() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('⭐ طبق الأسبوع', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Tajawal')),
          Text('المزيد', style: TextStyle(fontSize: 12, color: QawwatTheme.primary, fontFamily: 'Tajawal')),
        ]),
      ),
      SizedBox(
        height: 190,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _weekDishes.length,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (_, i) => DishCard(
            dish: _weekDishes[i],
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DishDetailScreen(dish: _weekDishes[i]))),
          ),
        ),
      ),
    ]);
  }

  Widget _buildTrending() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('🔥 الرائج الآن', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Tajawal')),
          Text('المزيد', style: TextStyle(fontSize: 12, color: QawwatTheme.primary, fontFamily: 'Tajawal')),
        ]),
      ),
      ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _trendingDishes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, i) => TrendItem(
          dish: _trendingDishes[i],
          badge: '🔥 ${312 - i * 60}',
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DishDetailScreen(dish: _trendingDishes[i]))),
        ),
      ),
    ]);
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _navIndex,
      onTap: (i) => setState(() => _navIndex = i),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'الرئيسية'),
        BottomNavigationBarItem(icon: Icon(Icons.map_outlined), activeIcon: Icon(Icons.map), label: 'رادار'),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), activeIcon: Icon(Icons.add_circle), label: 'أضف'),
        BottomNavigationBarItem(icon: Icon(Icons.emoji_events_outlined), activeIcon: Icon(Icons.emoji_events), label: 'أسطوري'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'حسابي'),
      ],
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String emoji, label, subtitle;
  final Color bgColor, borderColor;
  final VoidCallback onTap;

  const _ActionBtn({required this.emoji, required this.label, required this.subtitle, required this.bgColor, required this.borderColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 0.5),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, fontFamily: 'Tajawal')),
          Text(subtitle, style: const TextStyle(fontSize: 11, color: Color(0xFF888888), fontFamily: 'Tajawal')),
        ]),
      ),
    );
  }
}

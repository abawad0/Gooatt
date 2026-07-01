import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../models/models.dart';

class DishCard extends StatelessWidget {
  final Dish dish;
  final VoidCallback onTap;

  const DishCard({super.key, required this.dish, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFEAE8E4), width: 0.5),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 90,
            width: double.infinity,
            color: QawwatTheme.dishBg,
            child: Center(child: Text(dish.emoji, style: const TextStyle(fontSize: 36))),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(dish.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Tajawal'), maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 2),
              Text(dish.restaurantName, style: const TextStyle(fontSize: 11, color: Color(0xFF888888), fontFamily: 'Tajawal'), maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 6),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('★ ${dish.score}', style: const TextStyle(fontSize: 11, color: Color(0xFFE8A020), fontFamily: 'Tajawal')),
                Text('${dish.price.toInt()} ر.س', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: QawwatTheme.primary, fontFamily: 'Tajawal')),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }
}

class TrendItem extends StatelessWidget {
  final Dish dish;
  final String badge;
  final VoidCallback onTap;

  const TrendItem({super.key, required this.dish, required this.badge, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEAE8E4), width: 0.5),
        ),
        child: Row(children: [
          Text(dish.emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(dish.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Tajawal')),
              Text('${dish.restaurantName} · ${dish.district}', style: const TextStyle(fontSize: 11, color: Color(0xFF888888), fontFamily: 'Tajawal')),
            ]),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: QawwatTheme.primaryLight, borderRadius: BorderRadius.circular(10)),
            child: Text(badge, style: const TextStyle(fontSize: 10, color: QawwatTheme.primaryDark, fontWeight: FontWeight.w600, fontFamily: 'Tajawal')),
          ),
        ]),
      ),
    );
  }
}

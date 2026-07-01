// ─── Dish Model ───────────────────────────────────────────────
class Dish {
  final String id;
  final String name;
  final String restaurantName;
  final String district;
  final String city;
  final String category;
  final double price;
  final double score;
  final int reviewCount;
  final String emoji;
  final bool isLegendary;

  const Dish({
    required this.id,
    required this.name,
    required this.restaurantName,
    required this.district,
    required this.city,
    required this.category,
    required this.price,
    required this.score,
    required this.reviewCount,
    required this.emoji,
    this.isLegendary = false,
  });

  factory Dish.fromJson(Map<String, dynamic> json) => Dish(
    id: json['id'],
    name: json['name'],
    restaurantName: json['restaurant_name'],
    district: json['district'] ?? '',
    city: json['city'] ?? '',
    category: json['category'],
    price: (json['price'] as num).toDouble(),
    score: (json['score'] as num).toDouble(),
    reviewCount: json['review_count'] ?? 0,
    emoji: json['emoji'] ?? '🍽️',
    isLegendary: json['is_legendary'] ?? false,
  );
}

// ─── Rating Model ─────────────────────────────────────────────
class Rating {
  final String id;
  final String dishId;
  final String userId;
  final double taste;
  final double value;
  final double cleanliness;
  final double speed;
  final double score;
  final String? comment;
  final DateTime createdAt;

  const Rating({
    required this.id,
    required this.dishId,
    required this.userId,
    required this.taste,
    required this.value,
    required this.cleanliness,
    required this.speed,
    required this.score,
    this.comment,
    required this.createdAt,
  });

  // Score formula: taste*0.4 + value*0.3 + cleanliness*0.15 + speed*0.15
  static double calculateScore({
    required double taste,
    required double value,
    required double cleanliness,
    required double speed,
  }) {
    return (taste * 0.40) + (value * 0.30) + (cleanliness * 0.15) + (speed * 0.15);
  }
}

// ─── User Profile Model ───────────────────────────────────────
class UserProfile {
  final String id;
  final String name;
  final String city;
  final String? avatarUrl;
  final int totalRatings;
  final int citiesCount;
  final int legendaryCount;
  final bool isPro;
  final String badgeTitle;

  const UserProfile({
    required this.id,
    required this.name,
    required this.city,
    this.avatarUrl,
    required this.totalRatings,
    required this.citiesCount,
    required this.legendaryCount,
    this.isPro = false,
    this.badgeTitle = '',
  });
}

// ─── Category Model ───────────────────────────────────────────
class FoodCategory {
  final String id;
  final String nameAr;
  final String emoji;

  const FoodCategory({
    required this.id,
    required this.nameAr,
    required this.emoji,
  });

  static const List<FoodCategory> all = [
    FoodCategory(id: 'shawarma', nameAr: 'شاورما', emoji: '🌯'),
    FoodCategory(id: 'burger', nameAr: 'برغر', emoji: '🍔'),
    FoodCategory(id: 'pizza', nameAr: 'بيتزا', emoji: '🍕'),
    FoodCategory(id: 'coffee', nameAr: 'قهوة', emoji: '☕'),
    FoodCategory(id: 'breakfast', nameAr: 'فطور', emoji: '🥞'),
    FoodCategory(id: 'sweets', nameAr: 'حلويات', emoji: '🍰'),
    FoodCategory(id: 'drinks', nameAr: 'مشروبات', emoji: '🥤'),
    FoodCategory(id: 'popular', nameAr: 'أكلات شعبية', emoji: '🍲'),
    FoodCategory(id: 'healthy', nameAr: 'أكلات صحية', emoji: '🥗'),
  ];
}

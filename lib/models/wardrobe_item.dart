import 'package:hive/hive.dart';

part 'wardrobe_item.g.dart';

@HiveType(typeId: 1)
class WardrobeItem extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String imagePath;

  @HiveField(2)
  late List<String> dominantColors;

  @HiveField(3)
  late String category;

  @HiveField(4)
  String? season;

  @HiveField(5)
  String? occasion;

  @HiveField(6)
  late DateTime addedAt;

  @HiveField(7)
  List<String>? tags;

  WardrobeItem({
    required this.id,
    required this.imagePath,
    required this.dominantColors,
    required this.category,
    this.season,
    this.occasion,
    required this.addedAt,
    this.tags,
  });
}

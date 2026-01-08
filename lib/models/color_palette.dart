import 'package:hive/hive.dart';

part 'color_palette.g.dart';

@HiveType(typeId: 0)
class ColorPalette extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late List<String> hexColors;

  @HiveField(3)
  late DateTime createdAt;

  @HiveField(4)
  String? description;

  @HiveField(5)
  String? sourceImagePath;

  @HiveField(6)
  String? category;

  ColorPalette({
    required this.id,
    required this.name,
    required this.hexColors,
    required this.createdAt,
    this.description,
    this.sourceImagePath,
    this.category,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'colors': hexColors.map((hex) => {
        'hex': hex,
        'rgb': _hexToRgb(hex),
      }).toList(),
      'created': createdAt.toIso8601String(),
      'category': category,
      'description': description,
    };
  }

  // Convert from JSON
  factory ColorPalette.fromJson(Map<String, dynamic> json) {
    return ColorPalette(
      id: json['id'],
      name: json['name'],
      hexColors: (json['colors'] as List).map((c) => c['hex'] as String).toList(),
      createdAt: DateTime.parse(json['created']),
      category: json['category'],
      description: json['description'],
    );
  }

  List<int> _hexToRgb(String hex) {
    final color = int.parse(hex.substring(1), radix: 16);
    return [(color >> 16) & 0xFF, (color >> 8) & 0xFF, color & 0xFF];
  }
}

class Pictogram {
  final int id;
  final List<String> keywords;
  final List<String> categories;
  final bool? bestseller;
  final bool? schematic;
  final bool? sex;
  final bool? violence;
  final dynamic hair;
  final dynamic skin;
  final DateTime created;
  final DateTime lastUpdated;

  Pictogram({
    required this.id,
    required this.keywords,
    required this.categories,
    this.bestseller,
    this.schematic,
    this.sex,
    this.violence,
    this.hair,
    this.skin,
    required this.created,
    required this.lastUpdated,
  });

  factory Pictogram.fromJson(Map<String, dynamic> json) {
    List<String> extractKeywords() {
      if (json['keywords'] == null) return [];
      try {
        final List<dynamic> keywordsJson = json['keywords'];
        return keywordsJson
            .map((k) => (k is Map ? k['keyword']?.toString() : k?.toString()) ?? '')
            .where((k) => k.isNotEmpty)
            .toList();
      } catch (e) {
        return [];
      }
    }

    return Pictogram(
      id: json['_id'] is int ? json['_id'] : 0,
      keywords: extractKeywords(),
      categories: json['categories'] != null
          ? List<String>.from(json['categories'])
          : [],
      bestseller: json['bestseller'] is bool ? json['bestseller'] : null,
      schematic: json['schematic'] is bool ? json['schematic'] : null,
      sex: json['sex'] is bool ? json['sex'] : null,
      violence: json['violence'] is bool ? json['violence'] : null,
      hair: json['hair'],
      skin: json['skin'],
      created: DateTime.tryParse(json['created']?.toString() ?? '') ?? DateTime.now(),
      lastUpdated: DateTime.tryParse(json['lastUpdated']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  bool get isValid {
    // Filtrar pictogramas sin keywords o con IDs inválidos
    return id > 0 && keywords.isNotEmpty;
  }

  String getImageUrl({bool color = true, String? lang, int size = 500}) {
    final colorParam = color ? '' : '_nocolor';
    return 'https://static.arasaac.org/pictograms/$id/$id${colorParam}_$size.png';
  }

  String get firstKeyword => keywords.isNotEmpty ? keywords.first : 'Pictogram $id';
}

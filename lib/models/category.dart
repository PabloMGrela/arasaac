class Category {
  final String id;
  final String text;
  final String description;

  Category({
    required this.id,
    required this.text,
    required this.description,
  });

  factory Category.fromJson(String id, Map<String, dynamic> json) {
    return Category(
      id: id,
      text: json['text'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

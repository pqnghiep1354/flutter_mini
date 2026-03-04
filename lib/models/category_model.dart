class Category {
  final int id;
  final String name;
  final String? description;
  final String? thumb;
  final int? totalArticles;

  Category({
    required this.id,
    required this.name,
    this.description,
    this.thumb,
    this.totalArticles,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'],
      thumb: json['thumb'],
      totalArticles: json['total_articles'],
    );
  }
}

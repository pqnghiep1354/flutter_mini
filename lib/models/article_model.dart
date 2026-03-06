class Article {
  final int id;
  final String title;
  final String? description;
  final String? content;
  final String? thumb;
  final int? categoryId;
  final String? categoryName;
  final String? createdAt;
  final int? views;

  Article({
    required this.id,
    required this.title,
    this.description,
    this.content,
    this.thumb,
    this.categoryId,
    this.categoryName,
    this.createdAt,
    this.views,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      title: json['title'] ?? '',
      description: json['description'],
      content: json['content'],
      thumb: json['thumb'],
      categoryId: json['category_id'] is int
          ? json['category_id']
          : int.tryParse(json['category_id']?.toString() ?? ''),
      categoryName: json['category'] != null ? json['category']['name'] : null,
      createdAt: json['created_at'],
      views: json['views'] is int
          ? json['views']
          : int.tryParse(json['views']?.toString() ?? ''),
    );
  }
}

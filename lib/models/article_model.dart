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
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'],
      content: json['content'],
      thumb: json['thumb'],
      categoryId: json['category_id'],
      categoryName: json['category'] != null ? json['category']['name'] : null,
      createdAt: json['created_at'],
      views: json['views'],
    );
  }
}

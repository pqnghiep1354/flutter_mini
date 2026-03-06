import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../../models/article_model.dart';
import '../../../../widgets/article_card.dart';

class ArticleSliverBody extends StatelessWidget {
  final Article article;
  final List<Article> related;
  final void Function(Article) onRelatedTap;

  const ArticleSliverBody({
    super.key,
    required this.article,
    required this.related,
    required this.onRelatedTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (article.categoryName != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(article.categoryName!,
                  style: const TextStyle(
                      color: Color(0xFF6C63FF),
                      fontWeight: FontWeight.w600,
                      fontSize: 12)),
            ),
          const SizedBox(height: 14),
          Text(article.title,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E),
                  height: 1.3)),
          const SizedBox(height: 12),
          Row(children: [
            if (article.views != null) ...[
              Icon(Icons.visibility, size: 16, color: Colors.grey[500]),
              const SizedBox(width: 4),
              Text('${article.views} views',
                  style: TextStyle(color: Colors.grey[500], fontSize: 13)),
              const SizedBox(width: 16),
            ],
            if (article.createdAt != null) ...[
              Icon(Icons.access_time, size: 16, color: Colors.grey[500]),
              const SizedBox(width: 4),
              Text(article.createdAt!,
                  style: TextStyle(color: Colors.grey[500], fontSize: 13)),
            ],
          ]),
          const SizedBox(height: 16),
          Divider(color: Colors.grey[200]),
          const SizedBox(height: 8),
          if (article.description != null &&
              article.description!.isNotEmpty) ...[
            Text(article.description!,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                    fontStyle: FontStyle.italic,
                    height: 1.5)),
            const SizedBox(height: 16),
          ],
          if (article.content != null && article.content!.isNotEmpty)
            Html(data: article.content!),
          if (related.isNotEmpty) ...[
            const SizedBox(height: 24),
            Divider(color: Colors.grey[200]),
            const SizedBox(height: 16),
            const Row(children: [
              Icon(Icons.recommend, color: Color(0xFF6C63FF), size: 22),
              SizedBox(width: 8),
              Text('Related Articles',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E))),
            ]),
            const SizedBox(height: 12),
            ...related.map((ar) =>
                ArticleCard(article: ar, onTap: () => onRelatedTap(ar))),
          ],
        ]),
      ),
    );
  }
}

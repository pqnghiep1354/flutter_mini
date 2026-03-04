import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../models/article_model.dart';
import '../../widgets/article_card.dart';

class ArticleDetailContent extends StatelessWidget {
  final Article article;
  final List<Article> related;
  final void Function(Article) onRelatedTap;

  const ArticleDetailContent({
    super.key,
    required this.article,
    required this.related,
    required this.onRelatedTap,
  });

  @override
  Widget build(BuildContext context) {
    final a = article;
    return CustomScrollView(slivers: [
      SliverAppBar(
        expandedHeight: 250,
        pinned: true,
        backgroundColor: const Color(0xFF1A1A2E),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Share: ${a.title}'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bookmarked!'),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
        flexibleSpace: FlexibleSpaceBar(
          background: Hero(
            tag: 'article-thumb-${a.id}',
            child: a.thumb != null && a.thumb!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: a.thumb!,
                    fit: BoxFit.cover,
                    placeholder: (c, u) => Container(color: Colors.grey[300]),
                    errorWidget: (c, u, e) => Container(
                      color: Colors.grey[300],
                      child:
                          const Icon(Icons.image, size: 48, color: Colors.grey),
                    ),
                  )
                : Container(
                    color: const Color(0xFF6C63FF),
                    child: const Icon(Icons.article,
                        size: 64, color: Colors.white54),
                  ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (a.categoryName != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(a.categoryName!,
                    style: const TextStyle(
                        color: Color(0xFF6C63FF),
                        fontWeight: FontWeight.w600,
                        fontSize: 12)),
              ),
            const SizedBox(height: 14),
            Text(a.title,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E),
                    height: 1.3)),
            const SizedBox(height: 12),
            Row(children: [
              if (a.views != null) ...[
                Icon(Icons.visibility, size: 16, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text('${a.views} views',
                    style: TextStyle(color: Colors.grey[500], fontSize: 13)),
                const SizedBox(width: 16),
              ],
              if (a.createdAt != null) ...[
                Icon(Icons.access_time, size: 16, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(a.createdAt!,
                    style: TextStyle(color: Colors.grey[500], fontSize: 13)),
              ],
            ]),
            const SizedBox(height: 16),
            Divider(color: Colors.grey[200]),
            const SizedBox(height: 8),
            if (a.description != null && a.description!.isNotEmpty) ...[
              Text(a.description!,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      fontStyle: FontStyle.italic,
                      height: 1.5)),
              const SizedBox(height: 16),
            ],
            if (a.content != null && a.content!.isNotEmpty)
              Html(data: a.content!),
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
      ),
    ]);
  }
}

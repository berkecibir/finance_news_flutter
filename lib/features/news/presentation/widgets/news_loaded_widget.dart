import 'package:flutter/material.dart';
import '../widgets/news_article_item.dart';
import '../../../../domain/entities/news_article.dart';

class NewsLoadedWidget extends StatelessWidget {
  final List<NewsArticle> articles;
  final Future<void> Function() onRefresh;

  const NewsLoadedWidget({
    super.key,
    required this.articles,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return NewsArticleItem(article: article);
        },
      ),
    );
  }
}

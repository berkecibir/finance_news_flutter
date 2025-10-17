import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../domain/entities/news_article.dart';

class NewsArticleItem extends StatelessWidget {
  final NewsArticle article;

  const NewsArticleItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          // Haber linkine git
          if (article.url.isNotEmpty) {
            final Uri url = Uri.parse(article.url);
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Haber linki açılamadı')),
                );
              }
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tarih bilgisini göster
              Text(
                _formatDate(article.publishedAt),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 8),
              // Başlık
              Text(
                article.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              // Açıklama
              if (article.description.isNotEmpty)
                Text(
                  article.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(height: 16),
              // Okuma süresi ve action butonu
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Okuma süresi (tahmini)
                  Text(
                    '${_estimateReadingTime(article.content)} dk okuma',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                  // Oku butonu
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Tarihi formatla
  String _formatDate(String dateStr) {
    try {
      final DateTime date = DateTime.parse(dateStr);
      return '${date.day} ${_getMonthName(date.month)} ${date.year}';
    } catch (e) {
      return dateStr;
    }
  }

  // Ay ismini Türkçe olarak döndür
  String _getMonthName(int month) {
    const months = [
      'Ocak',
      'Şubat',
      'Mart',
      'Nisan',
      'Mayıs',
      'Haziran',
      'Temmuz',
      'Ağustos',
      'Eylül',
      'Ekim',
      'Kasım',
      'Aralık',
    ];
    return months[month - 1];
  }

  // Tahmini okuma süresi hesapla
  int _estimateReadingTime(String content) {
    const wordsPerMinute = 200;
    final int wordCount = content.split(RegExp(r'\s+')).length;
    return (wordCount / wordsPerMinute).ceil();
  }
}

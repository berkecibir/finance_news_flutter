// NewsArticle varlığı - Domain katmanında sadece temel veri yapıları
class NewsArticle {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  NewsArticle({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  // Domain katmanında sadece temel veri yapıları olduğu için
  // fromJson/toJson metodları burada değil, data katmanında olacak
}

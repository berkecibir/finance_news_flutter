import '../entities/news_article.dart';

// Domain katmanındaki soyut repository - dış dünyayla iletişim için sözleşme
abstract class NewsRepository {
  /// Finansal haberleri getirir
  /// [keywords] parametresi opsiyoneldir, belirtilirse haberler filtrelenir
  Future<List<NewsArticle>> getFinancialNews({String? keywords});
}

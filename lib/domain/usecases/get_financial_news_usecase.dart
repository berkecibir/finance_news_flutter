import '../entities/news_article.dart';
import '../repositories/news_repository.dart';

// Use case - Domain katmanında iş mantığını yöneten sınıf
class GetFinancialNewsUseCase {
  final NewsRepository repository;

  GetFinancialNewsUseCase(this.repository);

  /// Finansal haberleri getirir
  /// [keywords] parametresi opsiyoneldir, belirtilirse haberler filtrelenir
  Future<List<NewsArticle>> execute({String? keywords}) {
    return repository.getFinancialNews(keywords: keywords);
  }
}

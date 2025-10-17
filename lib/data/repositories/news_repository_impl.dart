import '../../domain/entities/news_article.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_data_source.dart';
import '../models/news_article_model.dart';

// Domain katmanındaki repository arayüzünün somut implementasyonu
class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<NewsArticle>> getFinancialNews({String? keywords}) async {
    final List<NewsArticleModel> models = await remoteDataSource
        .getFinancialNews(keywords: keywords);

    // Model'leri entity'lere dönüştür
    return models.map((model) => model.toEntity()).toList();
  }
}

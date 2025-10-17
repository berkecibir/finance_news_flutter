import '../../../../domain/entities/news_article.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsArticle> articles;

  NewsLoaded(this.articles);
}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);
}

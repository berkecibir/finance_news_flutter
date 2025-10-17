import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/get_financial_news_usecase.dart';
import '../../../../domain/entities/news_article.dart';
import 'news_state.dart';

// News uygulaması için Cubit implementasyonu
class NewsCubit extends Cubit<NewsState> {
  final GetFinancialNewsUseCase getFinancialNewsUseCase;

  NewsCubit({required this.getFinancialNewsUseCase}) : super(NewsInitial());

  /// Tüm haberleri getirir
  Future<void> fetchAllNews() async {
    emit(NewsLoading());
    try {
      final List<NewsArticle> articles = await getFinancialNewsUseCase
          .execute();
      emit(NewsLoaded(articles));
    } catch (e) {
      emit(NewsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  /// Anahtar kelimeye göre haberleri getirir
  Future<void> fetchNews({String? keywords}) async {
    // Anahtar kelime kontrolü
    if (keywords == null || keywords.trim().isEmpty) {
      emit(NewsError('Lütfen aramak için anahtar kelimeler girin'));
      return;
    }

    emit(NewsLoading());
    try {
      final List<NewsArticle> articles = await getFinancialNewsUseCase.execute(
        keywords: keywords,
      );
      emit(NewsLoaded(articles));
    } catch (e) {
      emit(NewsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}

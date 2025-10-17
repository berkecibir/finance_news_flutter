import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; // compute için gerekli
import '../models/news_article_model.dart';

// JSON çözümleme ve model haritalama işlemini izole bir iş parçacığında yapar.
// Bu fonksiyon mutlaka top-level (bir sınıfın içinde olmayan) olmalıdır.
List<NewsArticleModel> _parseNews(List<int> responseBodyBytes) {
  // 1. Byte'ları UTF8 kullanarak String'e çevir
  final String responseString = utf8.decode(responseBodyBytes);

  // 2. String'i Map'e decode et (EN YOĞUN İŞLEM)
  final Map<String, dynamic> responseBody = json.decode(responseString);

  // 3. Modelleri haritala
  if (responseBody.containsKey('data') && responseBody['data'] is List) {
    final List<dynamic> jsonList = responseBody['data'];
    return jsonList.map((json) => NewsArticleModel.fromJson(json)).toList();
  }

  // 'data' alanı yoksa boş liste döndür (hata işleme burada yapılmıyor, sadece başarılı cevabın parsing'i)
  return [];
}

// Harici veri kaynaklarıyla iletişim kuran sınıf
class NewsRemoteDataSource {
  // Canlı Render URL
  static const String baseUrl =
      'https://finance-news-python-backend.onrender.com';

  /// Finansal haberleri API'den getirir
  Future<List<NewsArticleModel>> getFinancialNews({String? keywords}) async {
    final Map<String, dynamic> queryParams = {};
    if (keywords != null && keywords.isNotEmpty) {
      queryParams['keywords'] = keywords;
    }

    final uri = Uri.parse(
      '$baseUrl/haberler',
    ).replace(queryParameters: queryParams);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // BAŞARILI CEVAP İŞLEME:
        // JSON DECODE VE MAPPING İŞLEMİNİ ARKA PLAN İŞ PARÇACIĞINA TAŞIYORUZ
        final articles = await compute(_parseNews, response.bodyBytes);

        // Eğer parseNews fonksiyonu boş bir liste döndürdüyse, Apilayer hatası kontrolü yap
        if (articles.isEmpty) {
          // Hata kontrolü için yine de anahtar kelimeyi decode etmemiz gerekebilir
          final Map<String, dynamic> responseBody = json.decode(
            utf8.decode(response.bodyBytes),
          );
          final String status =
              responseBody['request_status'] ?? 'Bilinmeyen Durum';
          if (status != 'success') {
            throw Exception(
              'Apilayer Durum Hatası: ${responseBody['message'] ?? 'İstek başarılı değil.'}',
            );
          }
        }
        return articles;
      } else {
        // HTTP HATA KODU (4xx veya 5xx) İŞLEME:
        Map<String, dynamic> errorBody = json.decode(
          utf8.decode(response.bodyBytes),
        );
        String errorMessage =
            errorBody['detail'] ?? 'Bilinmeyen bir hata oluştu.';

        throw Exception('API Hatası: ${response.statusCode} - $errorMessage');
      }
    } catch (e) {
      // Ağ veya kod hatası (Flutter tarafında)
      throw Exception('Bağlantı Hatası: ${e.toString()}');
    }
  }
}

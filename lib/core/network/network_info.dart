import 'package:http/http.dart' as http;

// Ağ bağlantısı kontrolü için yardımcı sınıf
class NetworkInfo {
  final http.Client client;

  NetworkInfo({required this.client});

  // Basit bağlantı kontrolü
  Future<bool> isConnected() async {
    try {
      final response = await client
          .get(
            Uri.parse('https://www.google.com'),
            headers: {'Connection': 'close'},
          )
          .timeout(Duration(seconds: 5));

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}

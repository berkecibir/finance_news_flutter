// Genel hata sınıfı
class Failure {
  final String message;

  Failure(this.message);
}

// Sunucu hatası
class ServerFailure extends Failure {
  ServerFailure(super.message);
}

// Önbellek hatası
class CacheFailure extends Failure {
  CacheFailure(super.message);
}

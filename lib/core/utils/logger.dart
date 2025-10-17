// Uygulama genelinde kullanılan logger
import 'package:flutter/material.dart';

class Logger {
  static void debug(String message) {
    // Debug modda çalışır
    assert(() {
      debugPrint('[DEBUG] $message');
      return true;
    }());
  }

  static void info(String message) {
    debugPrint('[INFO] $message');
  }

  static void error(String message) {
    debugPrint('[ERROR] $message');
  }

  static void warn(String message) {
    debugPrint('[WARN] $message');
  }
}

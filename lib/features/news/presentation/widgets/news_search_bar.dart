import 'package:flutter/material.dart';

class NewsSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearchPressed;
  final VoidCallback showEmptyWarning;
  final bool hasNewsLoaded;

  const NewsSearchBar({
    super.key,
    required this.controller,
    required this.onSearchPressed,
    required this.showEmptyWarning,
    required this.hasNewsLoaded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(
            Icons.search,
            color: Theme.of(context).iconTheme.color?.withValues(alpha: 0.6),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: (_) => _handleSearch(context),
              decoration: InputDecoration(
                hintText: 'Finansal terimlerle ara (ör: döviz, borsa)',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
              ),
            ),
          ),
          // Temizle butonu
          if (controller.text.isNotEmpty)
            IconButton(
              icon: Icon(
                Icons.clear,
                color: Theme.of(
                  context,
                ).iconTheme.color?.withValues(alpha: 0.6),
              ),
              onPressed: () => controller.clear(),
            ),
          // Arama butonu
          IconButton(
            icon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () => _handleSearch(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  void _handleSearch(BuildContext context) {
    if (controller.text.trim().isEmpty) {
      showEmptyWarning();
    } else if (!hasNewsLoaded) {
      // Haberler yüklenmemişse kullanıcıya uyarı göster
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen önce "Tüm Haberleri Getir" butonuna tıklayın'),
          backgroundColor: Colors.orange,
        ),
      );
    } else {
      onSearchPressed();
    }
  }
}

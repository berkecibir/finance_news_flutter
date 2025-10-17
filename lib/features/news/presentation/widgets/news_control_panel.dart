import 'package:flutter/material.dart';
import 'news_search_bar.dart';

class NewsControlPanel extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onFetchAllPressed;
  final VoidCallback onSearchPressed;
  final VoidCallback showEmptyWarning;
  final bool hasNewsLoaded;

  const NewsControlPanel({
    super.key,
    required this.controller,
    required this.onFetchAllPressed,
    required this.onSearchPressed,
    required this.showEmptyWarning,
    required this.hasNewsLoaded,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewsSearchBar(
          controller: controller,
          onSearchPressed: onSearchPressed,
          showEmptyWarning: showEmptyWarning,
          hasNewsLoaded: hasNewsLoaded,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onFetchAllPressed,
              icon: const Icon(Icons.article, size: 20),
              label: const Text('Tüm Haberleri Getir'),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

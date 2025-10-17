import 'package:flutter/material.dart';

class NewsLoadingWidget extends StatelessWidget {
  const NewsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Theme.of(context).progressIndicatorTheme.color,
          ),
          const SizedBox(height: 16),
          Text(
            'Haberler yükleniyor...',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

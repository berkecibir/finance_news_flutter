import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/news_cubit.dart';
import '../cubit/news_state.dart';
import '../widgets/news_control_panel.dart';
import '../widgets/news_loading_widget.dart';
import '../widgets/news_error_widget.dart';
import '../widgets/news_empty_widget.dart';
import '../widgets/news_initial_widget.dart';
import '../widgets/news_loaded_widget.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _hasNewsLoaded = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _fetchNewsArticles(BuildContext context) {
    if (_controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lütfen aramak için anahtar kelimeler girin'),
          backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
        ),
      );
      return;
    }

    final cubit = BlocProvider.of<NewsCubit>(context);
    cubit.fetchNews(keywords: _controller.text);
  }

  void _showEmptyWarning(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Lütfen aramak için anahtar kelimeler girin'),
        backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
      ),
    );
  }

  void _fetchAllNewsArticles(BuildContext context) {
    final cubit = BlocProvider.of<NewsCubit>(context);
    cubit.fetchAllNews();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Finans Haberleri')),
        body: Column(
          children: [
            NewsControlPanel(
              controller: _controller,
              onFetchAllPressed: () {
                _fetchAllNewsArticles(context);
                setState(() {
                  _hasNewsLoaded = true;
                });
              },
              onSearchPressed: () => _fetchNewsArticles(context),
              showEmptyWarning: () => _showEmptyWarning(context),
              hasNewsLoaded: _hasNewsLoaded,
            ),
            Expanded(
              child: BlocBuilder<NewsCubit, NewsState>(
                builder: (context, state) {
                  if (state is NewsLoading) {
                    return const NewsLoadingWidget();
                  } else if (state is NewsError) {
                    return NewsErrorWidget(
                      message: state.message,
                      onRetry: () {
                        _fetchAllNewsArticles(context);
                        setState(() {
                          _hasNewsLoaded = true;
                        });
                      },
                    );
                  } else if (state is NewsLoaded) {
                    if (!_hasNewsLoaded) {
                      setState(() {
                        _hasNewsLoaded = true;
                      });
                    }

                    if (state.articles.isEmpty) {
                      return const NewsEmptyWidget();
                    }

                    return NewsLoadedWidget(
                      articles: state.articles,
                      onRefresh: () async {
                        _fetchAllNewsArticles(context);
                        setState(() {
                          _hasNewsLoaded = true;
                        });
                      },
                    );
                  } else {
                    return const NewsInitialWidget();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

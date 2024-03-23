import 'package:flutter/material.dart';
import 'package:ict_flex_app/components/app_bar_component.dart';
import 'package:ict_flex_app/components/article_list_component.dart';
import 'package:ict_flex_app/services/feed_service.dart';
import 'package:ict_flex_app/services/storage_service.dart';
import 'package:ict_flex_app/state/feed_state.dart';
import 'package:ict_flex_app/state/page_state.dart';
import 'package:ict_flex_app/types/article.dart';

class IndexView extends StatefulWidget {
    const IndexView({super.key});

    @override
    State<IndexView> createState() => _IndexViewState();
}

class _IndexViewState extends State<IndexView> {
    final _storageService = StorageService();
    final _feedService = FeedService();
    final _feedState = FeedState();
    final _pageState = PageState();
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    List<Article>? _articles;

    @override
    void initState() {
        _pageState.article = null;
        _storageService.list(Article.table).then((x) => setState(() {
            _articles = x.map((y) => Article.fromMap(y)).toList();
            _fetchArticles();
        }));

        _feedState.addListener(_updateArticles);

        super.initState();
    }

    @override
    void dispose() {
        _feedState.removeListener(_updateArticles);
        super.dispose();
    }

    Future<void> _fetchArticles() async {
        List<Article>? old = List.from(_articles ?? []);

        try {
            List<Article> newArticles = await _feedService.articles();
            _feedState.articles = newArticles;
            for (var art in newArticles) {
                _storageService.insert(art);
            }

        } catch (e) {
            _newSnackbar('Could not reach server');
            _feedState.articles = (await _storageService.list(Article.table))
                .map((x) => Article.fromMap(x)).toList();

            return;
        }

        if (_feedService.diff(List.from(_articles ?? []), old).isEmpty) _newSnackbar('No new articles found');
    }

    void _updateArticles() => setState(() {
        _articles = _feedState.articles;
    });

    void _newSnackbar(String msg) {
        if (_scaffoldKey.currentContext == null) return;

        ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
            SnackBar(
                content: Text(
                    msg,
                    style: Theme.of(context).textTheme.labelSmall,
                ),
            )
        );
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: const AppBarComponent(),
            body: _articles == null
                ? const Text('Loading...')
                : ArticleListComponent(
                    articles: _articles ?? [],
                    onRefresh: _fetchArticles,
                ),
        );
    }
}

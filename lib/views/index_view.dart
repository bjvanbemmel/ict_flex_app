import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ict_flex_app/components/app_bar_component.dart';
import 'package:ict_flex_app/components/article_list_component.dart';
import 'package:ict_flex_app/services/feed_service.dart';
import 'package:ict_flex_app/services/storage_service.dart';
import 'package:ict_flex_app/state/feed_state.dart';
import 'package:ict_flex_app/state/page_state.dart';
import 'package:ict_flex_app/types/article.dart';
import 'package:ict_flex_app/types/read.dart';

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
    List<Read>? _reads;

    @override
    void initState() {
        _pageState.article = null;
        _initItems();

        _feedState.addListener(_updateArticles);

        super.initState();
    }

    @override
    void dispose() {
        _feedState.removeListener(_updateArticles);
        super.dispose();
    }

    void _initItems() async {
        _articles = Article.fromMapList(await _storageService.list(Article.table));
        _reads = Read.fromMapList(await _storageService.list(Read.table));
        _fetchArticles();
    }

    Future<void> _fetchArticles() async {
        _pageState.selected = null;

        try {
            List<Article> snapshot = List.from(_articles ?? []);

            List<Article> newArticles = await _feedService.articles();
            _feedState.articles = newArticles;

            _feedState.reads = Read.fromMapList(await _storageService.list(Read.table));

            final List<Article> added = _feedService.diff(newArticles, snapshot);
            for (var art in added) {
                _storageService.insert(art);
            }

            final List<Article> deleted = _feedService.diff(snapshot, newArticles);
            for (var art in deleted) {
                _storageService.delete(art);
            }

            if (added.isEmpty && deleted.isEmpty) {
                _newSnackbar('No new articles found');
            } else {
                _newSnackbar('Added ${added.length} article(s), deleted ${deleted.length} article(s)');
            }

        } catch (e) {
            _newSnackbar('Could not reach server');
            _feedState.articles = Article.fromMapList(
                await _storageService.list(Article.table)
            );
        }
    }

    void _updateArticles() => setState(() {
        _articles = _feedState.articles;
        _reads = _feedState.reads;
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
        return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
                systemNavigationBarColor: Theme.of(context).colorScheme.background,
            ),
            child: Scaffold(
                key: _scaffoldKey,
                appBar: const AppBarComponent(),
                body: ArticleListComponent(
                    articles: _articles ?? [],
                    reads: _reads ?? [],
                    onRefresh: _fetchArticles,
                ),
            ),
        );
    }
}

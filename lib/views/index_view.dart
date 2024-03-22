import 'package:flutter/material.dart';
import 'package:ict_flex_app/components/app_bar_component.dart';
import 'package:ict_flex_app/components/article_list_component.dart';
import 'package:ict_flex_app/services/feed_service.dart';
import 'package:ict_flex_app/state/page_state.dart';
import 'package:ict_flex_app/types/article.dart';

class IndexView extends StatefulWidget {
    const IndexView({super.key});

    @override
    State<IndexView> createState() => _IndexViewState();
}

class _IndexViewState extends State<IndexView> {
    final FeedService _feedService = FeedService();
    final PageState _pageState = PageState();

    @override
    initState() {
        _pageState.title = 'index';

        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: const AppBarComponent(),
            body: FutureBuilder<List<Article>>(
                future: _feedService.articles(),
                builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
                    return switch(snapshot.connectionState) {
                        ConnectionState.waiting => const Text('Loading...'),
                        ConnectionState.done => ArticleListComponent(
                            articles: snapshot.data ?? [],
                        ),
                        _ => Text(snapshot.error.toString()),
                    };
                },
            ),
        );
    }
}

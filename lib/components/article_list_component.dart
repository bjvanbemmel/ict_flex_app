import 'package:flutter/material.dart';
import 'package:ict_flex_app/components/article_tile_component.dart';
import 'package:ict_flex_app/services/feed_service.dart';
import 'package:ict_flex_app/services/storage_service.dart';
import 'package:ict_flex_app/state/feed_state.dart';
import 'package:ict_flex_app/types/article.dart';

class ArticleListComponent extends StatelessWidget {
    ArticleListComponent({
        super.key,
        required this.articles,
    });

    final List<Article> articles;
    final _storageService = StorageService();
    final _feedService = FeedService();
    final _feedState = FeedState();

    @override
    Widget build(BuildContext context) {
        void newSnackbar(String msg) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    msg,
                    style: Theme.of(context).textTheme.labelSmall,
                ),
            )
        );

        return RefreshIndicator(
            color: Theme.of(context).primaryColor,
            onRefresh: () async {
                int oldHash = articles.hashCode;
                try {
                    List<Article> newArticles = await _feedService.articles();
                    _feedState.articles = newArticles;
                    for (var art in newArticles) {
                        _storageService.insert(art);
                    }

                } catch (e) {
                    newSnackbar('Could not reach server');
                    _feedState.articles = (await _storageService.list(Article.table))
                        .map((x) => Article.fromMap(x)).toList();
                }

                if (oldHash == articles.hashCode) newSnackbar('No new articles found');
            },
            child: ListView(
                children: <Widget>[
                    for (var article in articles) ArticleTileComponent(
                        article: article,
                    ),
                ],
            ),
        );
    }
}

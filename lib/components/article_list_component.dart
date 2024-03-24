import 'package:flutter/material.dart';
import 'package:ict_flex_app/components/article_tile_component.dart';
import 'package:ict_flex_app/types/article.dart';
import 'package:ict_flex_app/types/read.dart';

class ArticleListComponent extends StatelessWidget {
    const ArticleListComponent({
        super.key,
        required this.onRefresh,
        required this.articles,
        required this.reads,
    });

    final List<Article> articles;
    final List<Read> reads;
    final Future<void> Function() onRefresh;

    @override
    Widget build(BuildContext context) {
        return RefreshIndicator(
            color: Theme.of(context).primaryColor,
            onRefresh: onRefresh,
            child: ListView(
                children: <Widget>[
                    for (var article in articles) ArticleTileComponent(
                        article: article,
                        read: reads.any((x) => x.articleId == article.hash),
                    ),
                ],
            ),
        );
    }
}

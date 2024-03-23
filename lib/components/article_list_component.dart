import 'package:flutter/material.dart';
import 'package:ict_flex_app/components/article_tile_component.dart';
import 'package:ict_flex_app/services/feed_service.dart';
import 'package:ict_flex_app/types/article.dart';

class ArticleListComponent extends StatelessWidget {
    ArticleListComponent({
        super.key,
        required this.articles,
    });

    final List<Article> articles;
    final _feedService = FeedService();

    @override
    Widget build(BuildContext context) {
        void verifyHash(int oldHash) {
            if (oldHash == articles.hashCode) {
                final snackBar = SnackBar(
                    content: Text(
                        'No new articles found',
                        style: Theme.of(context).textTheme.labelSmall,
                    ),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
        }

        return RefreshIndicator(
            color: Theme.of(context).primaryColor,
            onRefresh: () async {
                int oldHash = articles.hashCode;
                await _feedService.articles();
                verifyHash(oldHash);
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

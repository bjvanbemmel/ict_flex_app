import 'package:flutter/material.dart';
import 'package:ict_flex_app/components/article_tile_component.dart';
import 'package:ict_flex_app/services/feed_service.dart';
import 'package:ict_flex_app/types/article.dart';
import 'package:intl/intl.dart';

class ArticleListComponent extends StatelessWidget {
    const ArticleListComponent({
        super.key,
        required this.articles,
    });

    final List<Article> articles;

    @override
    Widget build(BuildContext context) {
        DateTime? lastUpdated = FeedService.lastUpdated;

        return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                for (var article in articles) ArticleTileComponent(
                    article: article,
                ),
                const Spacer(),
                if (lastUpdated != null) Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Text(
                        'Last updated at ${DateFormat('hh:mm:ss').format(lastUpdated)}'
                    ),
                ),
            ],
        );
    }
}

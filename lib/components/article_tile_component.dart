import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ict_flex_app/state/page_state.dart';
import 'package:ict_flex_app/types/article.dart';
import 'package:ict_flex_app/views/article_view.dart';
import 'package:intl/intl.dart';

class ArticleTileComponent extends StatelessWidget {
    ArticleTileComponent({
        super.key,
        required this.article,
    });

    final Article article;
    final PageState _pageState = PageState();

    @override
    Widget build(BuildContext context) {
        return InkWell(
            onTap: () {
                _pageState.article = article;

                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ArticleView(article: article,),
                    ),
                );
            },
            onLongPress: () async => await Clipboard.setData(ClipboardData(text: article.uri.toString())),
            child: Container(
                margin: const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Text(
                            article.title,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(
                            article.content,
                            overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                            DateFormat('d MMMM yyyy').format(article.createdAt),
                            style: Theme.of(context).textTheme.labelSmall
                        ),
                    ],
                ),
            ),
        );
    }
}

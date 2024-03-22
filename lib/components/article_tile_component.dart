import 'package:flutter/material.dart';
import 'package:ict_flex_app/types/article.dart';
import 'package:intl/intl.dart';

class ArticleTileComponent extends StatelessWidget {
    const ArticleTileComponent({
        super.key,
        required this.article,
    });

    final Article article;

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
                color: Colors.grey.shade50,
                boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.25),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: const Offset(0, 2),
                    ),
                ],
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Text(
                        article.title,
                        style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                        article.author,
                    ),
                    Row(
                        children: <Widget>[
                            Text(
                                DateFormat('yyyy-MM-dd').format(article.createdAt),
                            ),
                            const Spacer(),
                            Text(
                                DateFormat('hh:mm:ss').format(article.createdAt),
                            ),
                        ],
                    ),
                ],
            ),
        );
    }
}

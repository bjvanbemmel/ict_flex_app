import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ict_flex_app/components/app_bar_component.dart';
import 'package:ict_flex_app/services/storage_service.dart';
import 'package:ict_flex_app/state/feed_state.dart';
import 'package:ict_flex_app/types/article.dart';
import 'package:ict_flex_app/types/read.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleView extends StatelessWidget {
    ArticleView ({
        super.key,
        required this.article,
    }) {
        _storageService.insert(Read(
            articleId: article.hash,
        ));

        _storageService.list(Read.table).then((x) =>
            _feedState.reads = Read.fromMapList(x)
        );
    }

    final _storageService = StorageService();
    final _feedState = FeedState();
    final Article article;

    @override
    Widget build(BuildContext context) {
        Iterable<(int, String)> splitContent = article.content.split(' ').indexed;

        return Scaffold(
            appBar: const AppBarComponent(),
            body: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        SelectableText(
                            article.title,
                            style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Text(
                            DateFormat('d MMMM yyyy').format(article.createdAt),
                            style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(height: 12.0),
                        SelectableText.rich(
                            TextSpan(
                                children: <TextSpan>[
                                    for (final (i, word) in splitContent)
                                        word.startsWith(RegExp('(http(s)?://)'))
                                            ? TextSpan(
                                                text: i == splitContent.length - 1 ? word : '$word ',
                                                style: const TextStyle(
                                                    color: Colors.blue,
                                                    decoration: TextDecoration.underline,
                                                    decorationColor: Colors.blue,
                                                ),
                                                recognizer: TapGestureRecognizer()
                                                    ..onTap = () async {
                                                        Uri? uri = Uri.tryParse(word);
                                                        if (uri ==  null) return;
                                                        
                                                        await launchUrl(uri);
                                                    }
                                            )
                                            : TextSpan(
                                                text: i == splitContent.length - 1 ? word : '$word ',
                                            ),
                                ],
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}

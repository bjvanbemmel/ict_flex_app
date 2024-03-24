import 'package:flutter/material.dart';
import 'package:ict_flex_app/state/page_state.dart';
import 'package:ict_flex_app/types/article.dart';
import 'package:ict_flex_app/views/article_view.dart';
import 'package:intl/intl.dart';

class ArticleTileComponent extends StatefulWidget {
    const ArticleTileComponent({
        super.key,
        required this.article,
        required this.read,
    });

    final Article article;
    final bool read;

    @override
    State<ArticleTileComponent> createState() => _ArticleTileComponentState();
}

class _ArticleTileComponentState extends State<ArticleTileComponent> {
    final PageState _pageState = PageState();
    Article? _selected;

    @override
    void initState() {
        _pageState.addListener(_updateSelected);

        super.initState();
    }

    @override
    void dispose() {
        super.dispose();
    }

    void _updateSelected() => setState(() {
        _selected = _pageState.selected;
    });

    @override
    Widget build(BuildContext context) {
        return InkWell(
            onTap: () {
                _pageState.article = widget.article;
                _pageState.selected = null;

                Navigator.of(context).push(
                    PageRouteBuilder(
                        pageBuilder: (context, animation, anotherAnimation) =>
                            ArticleView(article: widget.article),
                        transitionsBuilder: (context, animation, anotherAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                            );
                        }
                    ),
                );
            },
            onLongPress: () => _pageState.selected = widget.article,
            child: Opacity(
                opacity: widget.read && _selected?.hash != widget.article.hash ? 0.5 : 1,
                child: Container(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
                    width: MediaQuery.sizeOf(context).width,
                    decoration: _selected?.hash == widget.article.hash ? BoxDecoration(
                        color: Colors.grey.shade300,
                    ) : const BoxDecoration(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Text(
                                widget.article.title,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text(
                                widget.article.content,
                                overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                                DateFormat('d MMMM yyyy').format(widget.article.createdAt),
                                style: Theme.of(context).textTheme.labelSmall
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}

import 'package:flutter/material.dart';
import 'package:ict_flex_app/services/feed_service.dart';
import 'package:ict_flex_app/state/page_state.dart';

class AppBarComponent extends StatefulWidget implements PreferredSizeWidget {
    const AppBarComponent({super.key});

    @override
    final Size preferredSize = const Size.fromHeight(kToolbarHeight);

    @override
    State<AppBarComponent> createState() => _AppBarComponentState();
}

class _AppBarComponentState extends State<AppBarComponent> {
    final FeedService _feedService = FeedService();
    final PageState _pageState = PageState();

    @override
    Widget build(BuildContext context) {
        return AppBar(
            title: Image.asset(
                'assets/images/logo.jpg',
                fit: BoxFit.fitHeight,
                width: 128.0,
            ),
            actions: <IconButton>[
                if (_pageState.title != 'index') IconButton(
                    icon: const Icon(Icons.share_rounded),
                    tooltip: 'Share article',
                    onPressed: () {},
                ),
                IconButton(
                    icon: const Icon(Icons.refresh_rounded),
                    tooltip: 'Reload content',
                    onPressed: () async {
                        await _feedService.articles();
                    },
                ),
            ],
        );
    }
}

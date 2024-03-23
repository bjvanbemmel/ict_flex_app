import 'package:flutter/material.dart';
import 'package:ict_flex_app/state/page_state.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarComponent extends StatefulWidget implements PreferredSizeWidget {
    const AppBarComponent({super.key});

    @override
    final Size preferredSize = const Size.fromHeight(kToolbarHeight);

    @override
    State<AppBarComponent> createState() => _AppBarComponentState();
}

class _AppBarComponentState extends State<AppBarComponent> {
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
                if (_pageState.article == null) IconButton(
                    icon: const Icon(Icons.calendar_month_rounded),
                    tooltip: 'View schedule',
                    onPressed: () => launchUrl(Uri.https('ict-flex.nl', 'rooster')),
                ),
                if (_pageState.article != null) IconButton(
                    icon: const Icon(Icons.share_rounded),
                    tooltip: 'Share article',
                    onPressed: () async {
                        Uri? uri = _pageState.article?.uri;
                        if (uri == null) return;

                        await Share.shareUri(uri);
                    },
                ),
                if (_pageState.article != null) IconButton(
                    icon: const Icon(Icons.open_in_browser_rounded),
                    tooltip: 'Open in browser',
                    onPressed: () async {
                        Uri? uri = _pageState.article?.uri;
                        if (uri == null) return;

                        await launchUrl(uri);
                    },
                ),
            ],
        );
    }
}

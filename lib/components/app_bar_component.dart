import 'package:flutter/material.dart';
import 'package:ict_flex_app/services/storage_service.dart';
import 'package:ict_flex_app/state/feed_state.dart';
import 'package:ict_flex_app/state/page_state.dart';
import 'package:ict_flex_app/types/article.dart';
import 'package:ict_flex_app/types/read.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarComponent extends StatefulWidget implements PreferredSizeWidget {
    const AppBarComponent({
        super.key,
        required this.article,
    });

    @override
    final Size preferredSize = const Size.fromHeight(kToolbarHeight);

    final Article? article;

    @override
    State<AppBarComponent> createState() => _AppBarComponentState();
}

class _AppBarComponentState extends State<AppBarComponent> {
    final _pageState = PageState();
    final _feedState = FeedState();
    final _storageService = StorageService();
    Article? _selected;

    @override
    void initState() {
        _pageState.addListener(_updateSelected);

        super.initState();
    }

    @override
    void dispose() {
        _pageState.removeListener(_updateSelected);
        super.dispose();
    }

    void _updateSelected() => setState(() {
        _selected = _pageState.selected;
    });

    List<IconButton> _indexActions() => [
        IconButton(
            icon: const Icon(Icons.calendar_month_rounded),
            tooltip: 'View schedule',
            onPressed: () => launchUrl(Uri.https('ict-flex.nl', 'rooster')),
        ),
    ];

    List<IconButton> _articleActions() => [
        IconButton(
            icon: const Icon(Icons.share_rounded),
            tooltip: 'Share article',
            onPressed: () async {
                Uri? uri = widget.article?.uri;
                if (uri == null) return;

                await Share.shareUri(uri);
            },
        ),
        IconButton(
            icon: const Icon(Icons.open_in_browser_rounded),
            tooltip: 'Open in browser',
            onPressed: () async {
                Uri? uri = widget.article?.uri;
                if (uri == null) return;

                await launchUrl(uri);
            },
        ),
    ];

    List<IconButton> _selectedActions() => [
        if (_feedState.reads.any((x) => x.articleId == _selected?.hash)) IconButton(
            icon: const Icon(Icons.mark_email_unread_rounded),
            tooltip: 'Mark as unread',
            onPressed: () async {
                await _storageService.delete(_feedState.reads.firstWhere((x) => x.articleId == _selected?.hash));
                _feedState.reads = Read.fromMapList(await _storageService.list(Read.table));
                _pageState.selected = null;
            },
        ) else IconButton(
            icon: const Icon(Icons.mark_email_read_rounded),
            tooltip: 'Mark as read',
            onPressed: () async {
                String? hash = _pageState.selected?.hash;
                if (hash == null) {
                    _pageState.selected = null;
                    return;
                }

                await _storageService.insert(Read(articleId: hash));
                _feedState.reads = Read.fromMapList(await _storageService.list(Read.table));
                _pageState.selected = null;
            },
        ),
        IconButton(
            icon: const Icon(Icons.share_rounded),
            tooltip: 'Share article',
            onPressed: () async {
                Uri? uri = _pageState.selected?.uri;
                if (uri == null) return;

                await Share.shareUri(uri);
                _pageState.selected = null;
            },
        ),
    ];

    @override
    Widget build(BuildContext context) {
        return AppBar(
            title: Image.asset(
                'assets/images/logo.jpg',
                fit: BoxFit.fitHeight,
                width: 128.0,
            ),
            actions: <IconButton>[
                if (_selected != null) ..._selectedActions() else
                if (widget.article == null) ..._indexActions() else
                ..._articleActions()
            ],
        );
    }
}

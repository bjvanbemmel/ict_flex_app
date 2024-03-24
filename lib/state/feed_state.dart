import 'package:flutter/material.dart';
import 'package:ict_flex_app/types/article.dart';
import 'package:ict_flex_app/types/read.dart';

class FeedState extends ChangeNotifier {
    static final FeedState _feedState = FeedState._internal();

    factory FeedState() {
        return _feedState;
    }

    FeedState._internal();

    List<Article> _articles = [];
    List<Article> get articles => _articles;
    set articles(List<Article> newArticles) {
        _articles = newArticles;
        _articles.sort((a, b) => b.createdAt.millisecondsSinceEpoch.compareTo(a.createdAt.millisecondsSinceEpoch));
        notifyListeners();
    }

    List<Read> _reads = [];
    List<Read> get reads => _reads;
    set reads(List<Read> newReads) {
        _reads = newReads;
        notifyListeners();
    }
}

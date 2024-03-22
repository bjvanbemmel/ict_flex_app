import 'package:flutter/material.dart';
import 'package:ict_flex_app/types/article.dart';

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
        notifyListeners();
    }
}

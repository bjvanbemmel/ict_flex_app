import 'package:flutter/material.dart';
import 'package:ict_flex_app/types/article.dart';

class PageState extends ChangeNotifier {
    static final PageState _pageState = PageState._internal();

    factory PageState() {
        return _pageState;
    }

    PageState._internal();

    Article? _article;
    Article? get article => _article;
    set article(Article? newArticle) {
        _article = newArticle;
        notifyListeners();
    }
}

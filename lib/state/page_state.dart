import 'package:flutter/material.dart';
import 'package:ict_flex_app/types/article.dart';

class PageState extends ChangeNotifier {
    static final PageState _pageState = PageState._internal();

    factory PageState() {
        return _pageState;
    }

    PageState._internal();

    Article? _selected;
    Article? get selected => _selected;
    set selected(Article? newSelected) {
        _selected = newSelected;
        notifyListeners();
    }
}

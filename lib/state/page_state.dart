import 'package:flutter/material.dart';

class PageState extends ChangeNotifier {
    static final PageState _pageState = PageState._internal();

    factory PageState() {
        return _pageState;
    }

    PageState._internal();

    String _title = '';
    String get title => _title;
    set title(String newTitle) {
        _title = newTitle;
        notifyListeners();
    }
}

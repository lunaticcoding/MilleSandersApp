import 'package:flutter/material.dart';

class NavigationService extends ChangeNotifier{
  PageController _pageViewController;
  int _page;

  NavigationService() {
    _page = 2;
    _pageViewController = PageController(initialPage: _page);
  }

  void jumpToPage(int page) {
    this._page = page;
    _pageViewController.jumpToPage(page);
    notifyListeners();
  }

  int getPage() => _page;
  PageController getPageController() => _pageViewController;
}

import 'package:flutter/material.dart';

class MilleSandersTabBarViewModel extends ChangeNotifier {
  int tabIndex = 2;

  void setTabIndex(int index) {
    tabIndex = index;
    notifyListeners();
  }
}
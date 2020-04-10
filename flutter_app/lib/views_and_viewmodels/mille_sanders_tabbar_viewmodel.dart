import 'package:flutter/material.dart';
import 'package:flutter_app/services/url_launcher_service.dart';

class MilleSandersTabBarViewModel extends ChangeNotifier {
  int tabIndex = 2;

  void setTabIndex(int index) {
    tabIndex = index;
    notifyListeners();
  }

  void launchInstagram() {
    UrlLauncherService.launchURL("https://www.instagram.com/mille_sanders/");
  }

  void launchPinterest() {
    UrlLauncherService.launchURL("https://www.pinterest.at/millesanders/");
  }
}
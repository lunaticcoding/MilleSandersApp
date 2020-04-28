import 'package:flutter/cupertino.dart';
import 'package:growthdeck/locator.dart';
import 'package:growthdeck/services/http_service.dart';
import 'package:growthdeck/services/navigation_service.dart';

class MilleSandersTabBarViewModel extends ChangeNotifier {
  NavigationService _navigationService;
  int page;

  MilleSandersTabBarViewModel() {
    _navigationService = locator<NavigationService>();
    page = _navigationService.getPage();
    notifyListeners();
  }

  void launchFacebook() {
    HttpService.launchURL("https://www.facebook.com/millesandersaustria/");
  }

  void launchLinkedin() {
    HttpService.launchURL("https://www.linkedin.com/company/millesanders-com");
  }

  void launchInstagram() {
    HttpService.launchURL("https://www.instagram.com/mille_sanders/");
  }

  void launchPinterest() {
    HttpService.launchURL("https://www.pinterest.at/millesanders/");
  }

  void jumpToPage(int page) {
    _navigationService.jumpToPage(page);
    this.page = page;
    notifyListeners();
  }
  PageController getPageController() => _navigationService.getPageController();
}

import 'package:flutter/cupertino.dart';
import 'package:growthdeck/services/http_service.dart';

class IntroductionViewModel extends ChangeNotifier {
  static void launchEmail() async {
    try {
      await HttpService.launchURL('mailto:contact@millesanders.com');
    } catch (e) {}
  }

  static void launchFacebookMessenger() async {
    try {
      await HttpService.launchURL('http://m.me/millesandersaustria');
    } catch (e) {}
  }
}

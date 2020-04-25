import 'package:flutter/cupertino.dart';
import 'package:growthdeck/services/http_service.dart';

class IntroductionViewModel extends ChangeNotifier {
  static void launchEmail() {
    try {
      HttpService.launchURL(
          'mailto:m.papula@gmx.at?subject="hello"&body="body"');
    } catch (e) {}
  }

  static void launchFacebookMessenger() {
    try {
      HttpService.launchURL('m.me/millesanders');
    } catch (e) {}
  }
}

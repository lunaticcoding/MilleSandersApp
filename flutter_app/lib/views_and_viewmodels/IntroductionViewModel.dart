import 'package:flutter/cupertino.dart';
import 'package:growthdeck/services/http_service.dart';

class IntroductionViewModel extends ChangeNotifier {
  static void launchEmail() async {
    try {
      await HttpService.launchURL(
          'mailto:m.papula@gmx.at?subject="hello"&body="body"');
    } catch (e) {}
  }

  static void launchFacebookMessenger() async {
    try {
      await HttpService.launchURL('m.me/millesanders');
    } catch (e) {}
  }
}

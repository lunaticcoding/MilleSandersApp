import 'package:flutter_app/services/url_launcher_service.dart';

class MilleSandersTabBarViewModel {

  static void launchFacebook() {
    UrlLauncherService.launchURL(
        "https://www.facebook.com/millesandersaustria/");
  }

  static void launchLinkedin() {
    UrlLauncherService.launchURL(
        "https://www.linkedin.com/company/millesanders-com");
  }

  static void launchInstagram() {
    UrlLauncherService.launchURL("https://www.instagram.com/mille_sanders/");
  }

  static void launchPinterest() {
    UrlLauncherService.launchURL("https://www.pinterest.at/millesanders/");
  }
}

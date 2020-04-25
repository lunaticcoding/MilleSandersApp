
import 'package:growthdeck/services/http_service.dart';

class MilleSandersTabBarViewModel {

  static void launchFacebook() {
    HttpService.launchURL(
        "https://www.facebook.com/millesandersaustria/");
  }

  static void launchLinkedin() {
    HttpService.launchURL(
        "https://www.linkedin.com/company/millesanders-com");
  }

  static void launchInstagram() {
    HttpService.launchURL("https://www.instagram.com/mille_sanders/");
  }

  static void launchPinterest() {
    HttpService.launchURL("https://www.pinterest.at/millesanders/");
  }
}

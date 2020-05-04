import 'package:url_launcher/url_launcher.dart';

class HttpService {
  const HttpService();

  static launchURL(String url) async {
    if (await canLaunch(url)) {
      try {
        await launch(url);
      } catch (e) {
        print(e);
      }
    }
  }
}

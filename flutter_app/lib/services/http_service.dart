import 'package:url_launcher/url_launcher.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class HttpService{
  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static dynamic getJson(String url) async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<int> bytes = response.body.toString().codeUnits;
      String decodedUtf8 = convert.utf8.decode(bytes);
      return convert.jsonDecode(decodedUtf8);
    } else {
      throw('Request failed with status: ${response.statusCode}');
    }
  }
}
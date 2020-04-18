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
    // TODO remove
    String data;
    if(url == "version") {
      data = "{ \"version\": 1.0}";
    }
    if(url == "data"){
      data = '''
      [{
        "sectionName": "Section Name",
            "decks": [{
                "deckName": "Deck Name A", 
                "icon": "idea", 
                "color": "#ff0000",
                "cards": [{
                    "html": "Hello\\nI am a test ;D This seems to work somehow\\n\\n- hello\\n- yes\\n",
                    "filter": ["money", "fame"]
                }]},
                {
                "deckName": "Deck Name B", 
                "icon": "idea", 
                "color": "#ff0000",
                "cards": [{
                    "html": "Html Code für Karte 1a",
                    "filter": ["money", "fame"]
                }]}, {
                "deckName": "Deck Name C", 
                "icon": "idea", 
                "color": "#0000ff",
                "cards": [{
                    "html": "Html Code für Karte 1a",
                    "filter": ["money", "fame"]}, 
                    { "html": "Html Code für Karte 1a",
                    "filter": ["money"]}]}
                ]},
        {"sectionName": "Section Name2",
        "decks": [{
            "deckName": "Deck Name2",
            "icon": "idea", 
            "color": "#00ff00",
            "cards": [{
                "html": "Html Code für Karte 1a",
                "filter": ["money", "fame"]}, 
                {"html": "Html Code für Karte 1a",
                "filter": ["money"]}]
        }]
    }]''';
    }

    return convert.jsonDecode(data);

    // TODO until here

//    var response = await http.get(url);
//    if (response.statusCode == 200) {
//      return convert.jsonDecode(response.body);
//    } else {
//      throw('Request failed with status: ${response.statusCode}');
//    }
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constants.dart';
import 'package:flutter_app/constants/the_noun_project_icons_icons.dart';
import 'package:flutter_app/locator.dart';
import 'package:flutter_app/services/http_service.dart';
import 'package:flutter_app/services/local_storage_service.dart';

class Cards extends ChangeNotifier {
  String error;
  LocalStorageService _localStorageService;
  dynamic data;

  static Future<Cards> create() async {
    Cards cards = Cards();
    cards._localStorageService = locator<LocalStorageService>();
    await cards._loadData();
    return cards;
  }

  Future<void> _loadData() async {
    double localVersion = await _localStorageService.getVersion();
    double newestVersion;
    try {
      try {
        newestVersion = (await HttpService.getJson(kVersionUrl))["version"];
      } catch (e) {
        data = await _localStorageService.getFile(kFileName);
        notifyListeners();
        return;
      }

      if (localVersion != null && localVersion == newestVersion) {
        data = await _localStorageService.getFile(kFileName);
        notifyListeners();
        return;
      } else {
        await reloadData();
      }
    } catch (e) {
      await reloadData();
    }
  }

  Future<void> reloadData() async {
    error = null;
    notifyListeners();
    try {
      double newestVersion = (await HttpService.getJson(kVersionUrl))["version"];
      data = await HttpService.getJson(kDataUrl);
      _localStorageService.writeFile(kFileName, data);
      _localStorageService.setVersion(newestVersion);
    } catch (e) {
      error =
          "Make sure you are connected to the internet. If the error persists, contact the us at email.";
    }
    notifyListeners();
  }

  static Color colorFromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static IconData getIcon(String icon) {
    switch (icon) {
      case "quotes":
        return TheNounProjectIcons.noun_quotes;
      case "tips":
        return TheNounProjectIcons.noun_tips;
      case "exit":
        return TheNounProjectIcons.noun_exit;
      case "peak":
        return TheNounProjectIcons.noun_peak;
      case "business idea":
        return TheNounProjectIcons.noun_business_idea;
      case "book":
        return TheNounProjectIcons.noun_write;
      default:
        return TheNounProjectIcons.noun_idea;
    }
  }
}

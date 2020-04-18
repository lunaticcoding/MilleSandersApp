import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/k_colors.dart';
import 'package:flutter_app/locator.dart';
import 'package:flutter_app/services/http_service.dart';
import 'package:flutter_app/services/local_storage_service.dart';

class Cards extends ChangeNotifier {
  final String _fileName = "cardContent";
  LocalStorageService _localStorageService;
  dynamic data;

  static Future<Cards> create() async {
    Cards cards = Cards();
    cards._localStorageService =  locator<LocalStorageService>();
    await cards._loadData();

    return cards;
  }

  Future<void> _loadData() async {
    double localVersion = await _localStorageService.getVersion();
    double newestVersion = (await HttpService.getJson("version"))["version"];

    if ((localVersion == newestVersion) ||
        (localVersion > 0 && newestVersion < 0)) {
      data = await _localStorageService.getFile(_fileName);
    } else {
      data = await HttpService.getJson("data");
//      await reloadData(newestVersion);
    }
  }

  Future<void> reloadData(double newestVersion) async {
    dynamic data = await HttpService.getJson("url");
    _localStorageService.writeFile(_fileName, data.toString());
    _localStorageService.setVersion(newestVersion);
    notifyListeners();
  }

}

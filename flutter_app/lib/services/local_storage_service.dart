import 'dart:convert' as convert;
import 'dart:io';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  SharedPreferences _prefs;
  Directory _directory;

  static Future<LocalStorageService> create() async {
    var localStorageService = LocalStorageService._create();
    localStorageService._prefs = await SharedPreferences.getInstance();
    localStorageService._directory = await getApplicationDocumentsDirectory();
    return localStorageService;
  }
  LocalStorageService._create();

  Future<double> getVersion() async {
    if (_prefs.containsKey("version")) {
      return _prefs.getDouble("version");
    }
    return null;
  }

  Future<void> setVersion(double version) async {
      await _prefs.setDouble("version", version);
  }

  Future<dynamic> getFile(String fileName) async {
    String contents =
        await File('${_directory.path}/$fileName.txt').readAsString();
    return convert.jsonDecode(contents);
  }

  Future<void> writeFile(String fileName, dynamic json) async {
    await File('${_directory.path}/$fileName.txt').writeAsString(convert.jsonEncode(json));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:growthdeck/services/http_service.dart';
import 'package:growthdeck/services/local_storage_service.dart';
import 'package:growthdeck/services/navigation_service.dart';
import 'package:provider/provider.dart';
import 'models/Decks.dart';
import 'views/navigation_view.dart';

void main() async => {
  WidgetsFlutterBinding.ensureInitialized(),
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
  runApp(MyApp())
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mille Sanders',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<NavigationService>(
              create: (context) => NavigationService()),
          FutureProvider<LocalStorageService>(
              create: (context) => LocalStorageService.create()),
          Provider(create: (context) => HttpService()),
          ChangeNotifierProxyProvider2<LocalStorageService, HttpService, Decks>(
              create: (BuildContext context) => Decks(),
              update: (context, localStorageService, httpService, card) =>
                  card..loadData(localStorageService, httpService)),
        ],
        child: NavigationView(),
      ),
    );
  }
}

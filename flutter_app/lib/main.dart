import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:growthdeck/services/local_storage_service.dart';
import 'package:growthdeck/services/navigation_service.dart';
import 'package:provider/provider.dart';
import 'models/Cards.dart';
import 'views_and_viewmodels/navigation_view.dart';

void main() {
  runApp(MyApp());
}

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
          ChangeNotifierProxyProvider<LocalStorageService, Cards>(
              create: (BuildContext context) => Cards(),
              update: (context, localStorageService, card) =>
                  card..loadData(localStorageService)),
        ],
        child: NavigationView(),
      ),
    );
  }
}

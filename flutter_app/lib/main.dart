import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:growthdeck/services/http_service.dart';
import 'package:growthdeck/services/navigation_service.dart';
import 'package:provider/provider.dart';
import 'models/Decks.dart';
import 'views/navigation_view.dart';

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
          ChangeNotifierProvider(create: (context) => Decks()),
          Provider(create: (context) => HttpService()),
        ],
        child: NavigationView(),
      ),
    );
  }
}

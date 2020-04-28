import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:growthdeck/locator.dart';
import 'views_and_viewmodels/mille_sanders_tabbar_view.dart';

void main() {
  setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mille Sanders',
      home: MilleSandersTabBarView(),
    );
  }
}

import 'package:flutter/material.dart';
import 'views_and_viewmodels/mille_sanders_tabbar_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mille Sanders',
      home: MilleSandersTabBarView(),
    );
  }
}

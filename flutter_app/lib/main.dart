import 'package:flutter/material.dart';
import 'package:flutter_app/constants/k_colors.dart';
import 'ViewsAndViewModels/mille_sanders_tabbar_view.dart';

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

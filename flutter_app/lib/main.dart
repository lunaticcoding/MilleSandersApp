import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'models/Cards.dart';
import 'views_and_viewmodels/mille_sanders_tabbar_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Cards()),
      ],
      child: CupertinoApp(
        title: 'Mille Sanders',
        home: MilleSandersTabBarView(),
      ),
    );
  }
}

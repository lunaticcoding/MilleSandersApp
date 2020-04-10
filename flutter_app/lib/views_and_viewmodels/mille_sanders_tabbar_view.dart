import 'package:flutter/material.dart';
import 'package:flutter_app/views_and_viewmodels/card_deck_selection_tab_view.dart';
import 'package:flutter_app/views_and_viewmodels/mille_sanders_tabbar_viewmodel.dart';
import 'package:flutter_app/constants/k_colors.dart';
import 'package:flutter_app/constants/the_noun_project_icons_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

class MilleSandersTabBarView extends StatefulWidget {
  MilleSandersTabBarView({Key key}) : super(key: key);

  @override
  _MilleSandersTabBarViewState createState() => _MilleSandersTabBarViewState();
}

class _MilleSandersTabBarViewState extends State<MilleSandersTabBarView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      viewModel: MilleSandersTabBarViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "MILLE SANDERS",
                  style: GoogleFonts.bebasNeue(
                    textStyle:
                        TextStyle(color: Colors.black, letterSpacing: 0.8, fontSize: 21),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      padding: EdgeInsets.all(0),
                      iconSize: 33,
                      onPressed: model.launchPinterest,
                      icon: Icon(
                        TheNounProjectIcons.pinterest,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.all(0),
                      iconSize: 33,
                      onPressed: model.launchInstagram,
                      icon: Icon(
                        TheNounProjectIcons.instagram,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            centerTitle: false,
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
        ),
        body: [
          Container(child: Text("1")),
          Container(child: Text("2")),
          CardDeckSelectionTabView(),
          Container(child: Text("4")),
          Container(child: Text("5")),
        ][model.tabIndex],
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Divider(
                thickness: 3,
                color: kColors.gold,
              ),
              BottomNavigationBar(
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                currentIndex: model.tabIndex,
                backgroundColor: Colors.white,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey[400],
                iconSize: 25,
                onTap: model.setTabIndex,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(TheNounProjectIcons.logo_millesanders),
                    title: Container(
                      height: 0,
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(TheNounProjectIcons.noun_hub),
                    title: Container(
                      height: 0,
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(TheNounProjectIcons.noun_overview),
                    title: Container(
                      height: 0,
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(TheNounProjectIcons.noun_unlock),
                    title: Container(
                      height: 0,
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(TheNounProjectIcons.noun_authorization),
                    title: Container(
                      height: 0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

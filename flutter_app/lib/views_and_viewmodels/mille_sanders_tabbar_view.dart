import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/mille_sanders_icons.dart';
import 'package:flutter_app/views_and_viewmodels/card_deck_selection_tab_view.dart';
import 'package:flutter_app/views_and_viewmodels/mille_sanders_tabbar_viewmodel.dart';
import 'package:flutter_app/constants/k_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MilleSandersTabBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
    CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: Border(
          bottom: BorderSide(
            color: kColors.gold,
            width: 1.0, // One physical pixel.
            style: BorderStyle.solid,
          ),
        ),
        leading: Center(
          child: Text(
            "MILLE SANDERS",
            style: GoogleFonts.bebasNeue(
              textStyle: TextStyle(
                  color: Colors.black, letterSpacing: 0.8, fontSize: 21),
            ),
          ),
        ),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              onTap: MilleSandersTabBarViewModel.launchFacebook,
              child: Icon(
                MilleSanders.facebook,
                color: Colors.black,
                size: 33,
              ),
            ),
            GestureDetector(
              onTap: MilleSandersTabBarViewModel.launchLinkedin,
              child: Icon(
                MilleSanders.linkedin,
                color: Colors.black,
                size: 33,
              ),
            ),
            GestureDetector(
              onTap: MilleSandersTabBarViewModel.launchPinterest,
              child: Icon(
                MilleSanders.pinterest,
                color: Colors.black,
                size: 33,
              ),
            ),
            GestureDetector(
              onTap: MilleSandersTabBarViewModel.launchInstagram,
              child: Icon(
                MilleSanders.instagram,
                color: Colors.black,
                size: 33,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      child: CupertinoTabScaffold(
        tabBuilder: (BuildContext context, int index) => CupertinoTabView(
          builder: (BuildContext context) => [
            Container(child: Text("1")),
            Container(child: Text("2")),
            CardDeckSelectionTabView(),
            Container(child: Text("4")),
            Container(child: Text("5")),
          ][index],
        ),
        tabBar: CupertinoTabBar(
          border: Border(
            top: BorderSide(
              color: kColors.gold,
              width: 1.0, // One physical pixel.
              style: BorderStyle.solid,
            ),
          ),
          currentIndex: 2,
          backgroundColor: Colors.white,
          activeColor: Colors.black,
          inactiveColor: Colors.grey[400],
          iconSize: 25,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(MilleSanders.logo_millesanders),
              title: Container(
                height: 0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(MilleSanders.noun_hub),
              title: Container(
                height: 0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(MilleSanders.noun_overview),
              title: Container(
                height: 0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(MilleSanders.noun_unlock),
              title: Container(
                height: 0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(MilleSanders.noun_authorization),
              title: Container(
                height: 0,
              ),
            ),
          ],
        ),
      ),
    );
}

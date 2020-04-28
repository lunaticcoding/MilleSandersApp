import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:growthdeck/constants/mille_sanders_icons.dart';
import 'package:growthdeck/views_and_viewmodels/introduction_view.dart';
import 'package:growthdeck/views_and_viewmodels/impressum_view.dart';
import 'package:growthdeck/views_and_viewmodels/MilleSandersWebView.dart';
import 'package:growthdeck/views_and_viewmodels/card_deck_selection_tab_view.dart';
import 'package:growthdeck/views_and_viewmodels/mille_sanders_tabbar_viewmodel.dart';
import 'package:growthdeck/constants/k_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MilleSandersTabBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: Border(
            bottom: BorderSide(
              color: kColors.gold,
              width: 1.0, // One physical pixel.
              style: BorderStyle.solid,
            ),
          ),
          automaticallyImplyLeading: false,
          middle: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "MILLE SANDERS",
              style: GoogleFonts.bebasNeue(
                textStyle: TextStyle(
                    color: Colors.black, letterSpacing: 0.8, fontSize: 21),
              ),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
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
              IntroductionView(),,
              MilleSandersWebView('https://millesanders.com/blogs/tipps'),
              CardDeckSelectionTabView(),
              MilleSandersWebView('https://millesanders.com/'),
              ImpressumView(),
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
                icon: Icon(MilleSanders.noun_blog),
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
                icon: Icon(MilleSanders.noun_shop),
                title: Container(
                  height: 0,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(MilleSanders.noun_info),
                title: Container(
                  height: 0,
                ),
              ),
            ],
          ),
        ),
      );
}

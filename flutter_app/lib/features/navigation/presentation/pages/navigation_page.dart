import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:growthdeck/constants/mille_sanders_icons.dart';
import 'package:growthdeck/features/navigation/presentation/pages/imprint_page.dart';
import 'package:growthdeck/services/http_service.dart';
import 'package:growthdeck/widgets/MSWebView.dart';
import 'package:growthdeck/features/card_deck/presentation/pages/card_deck_page.dart';
import 'package:growthdeck/constants/k_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import 'introduction_page.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _pageIndex = 1;
  List<Widget> _pages = [
    IntroductionPage(),
    MSWebView('https://millesanders.com/blogs/tipps'),
    CardDeckPage(),
    MSWebView('https://millesanders.com/'),
    ImprintPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: kColors.gold,
              height: 1.0,
            ),
            preferredSize: Size.fromHeight(1.0)),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "MILLE SANDERS",
                style: GoogleFonts.bebasNeue(
                  textStyle: TextStyle(
                      color: Colors.black, letterSpacing: 0.8, fontSize: 21),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () => HttpService.launchURL(
                      'https://www.facebook.com/millesandersaustria/'),
                  child: Icon(
                    MilleSanders.facebook,
                    color: Colors.black,
                    size: 33,
                  ),
                ),
                GestureDetector(
                  onTap: () => HttpService.launchURL(
                      'https://www.linkedin.com/company/millesanders-com'),
                  child: Icon(
                    MilleSanders.linkedin,
                    color: Colors.black,
                    size: 33,
                  ),
                ),
                GestureDetector(
                  onTap: () => HttpService.launchURL(
                      'https://www.pinterest.at/millesanders/'),
                  child: Icon(
                    MilleSanders.pinterest,
                    color: Colors.black,
                    size: 33,
                  ),
                ),
                GestureDetector(
                  onTap: () => HttpService.launchURL(
                      'https://www.instagram.com/mille_sanders/'),
                  child: Icon(
                    MilleSanders.instagram,
                    color: Colors.black,
                    size: 33,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: _pages[_pageIndex],
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 1,
                color: kColors.gold,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(MilleSanders.logo_millesanders),
                color: _pageIndex == 0 ? Colors.black : Colors.grey,
                onPressed: () {
                  setState(() {
                    _pageIndex = 0;
                  });
                },
              ),
              IconButton(
                icon: Icon(MilleSanders.noun_blog),
                color: _pageIndex == 1 ? Colors.black : Colors.grey,
                onPressed: () {
                  setState(() {
                    _pageIndex = 1;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  MilleSanders.noun_overview,
                ),
                color: _pageIndex == 2 ? Colors.black : Colors.grey,
                onPressed: () {
                  setState(() {
                    if (_pageIndex == 2) {
                      _pages[_pageIndex] = CardDeckPage();
                    } else {
                      _pageIndex = 2;
                    }
                  });
                },
              ),
              IconButton(
                icon: Icon(MilleSanders.noun_shop),
                color: _pageIndex == 3 ? Colors.black : Colors.grey,
                onPressed: () {
                  setState(() {
                    _pageIndex = 3;
                  });
                },
              ),
              IconButton(
                icon: Icon(MilleSanders.noun_info),
                color: _pageIndex == 4 ? Colors.black : Colors.grey,
                onPressed: () {
                  setState(() {
                    _pageIndex = 4;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

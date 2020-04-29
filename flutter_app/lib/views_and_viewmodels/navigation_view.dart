import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:growthdeck/constants/mille_sanders_icons.dart';
import 'package:growthdeck/services/http_service.dart';
import 'package:growthdeck/services/navigation_service.dart';
import 'package:growthdeck/views_and_viewmodels/card_display_view.dart';
import 'package:growthdeck/views_and_viewmodels/introduction_view.dart';
import 'package:growthdeck/views_and_viewmodels/impressum_view.dart';
import 'package:growthdeck/widgets/MSWebView.dart';
import 'package:growthdeck/views_and_viewmodels/deck_selection_view.dart';
import 'package:growthdeck/constants/k_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NavigationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavigationService navigationService =
        Provider.of<NavigationService>(context);
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
      body: PageView(
        controller: navigationService.getPageController(),
        children: <Widget>[
          IntroductionView(),
          MSWebView('https://millesanders.com/blogs/tipps'),
          DeckSelectionView(),
          MSWebView('https://millesanders.com/'),
          ImpressumView(),
          CardDisplayView(),
        ],
      ),
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
                color: navigationService.getPage() == 0
                    ? Colors.black
                    : Colors.grey,
                onPressed: () {
                  navigationService.jumpToPage(0);
                },
              ),
              IconButton(
                icon: Icon(MilleSanders.noun_blog),
                color: navigationService.getPage() == 1
                    ? Colors.black
                    : Colors.grey,
                onPressed: () {
                  navigationService.jumpToPage(1);
                },
              ),
              IconButton(
                icon: Icon(
                  MilleSanders.noun_overview,
                ),
                color: navigationService.getPage() == 2
                    ? Colors.black
                    : Colors.grey,
                onPressed: () {
                  navigationService.jumpToPage(2);
                },
              ),
              IconButton(
                icon: Icon(MilleSanders.noun_shop),
                color: navigationService.getPage() == 3
                    ? Colors.black
                    : Colors.grey,
                onPressed: () {
                  navigationService.jumpToPage(3);
                },
              ),
              IconButton(
                icon: Icon(MilleSanders.noun_info),
                color: navigationService.getPage() == 4
                    ? Colors.black
                    : Colors.grey,
                onPressed: () {
                  navigationService.jumpToPage(4);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

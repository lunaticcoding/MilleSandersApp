import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:growthdeck/constants/mille_sanders_icons.dart';
import 'package:growthdeck/views_and_viewmodels/card_deck_selection_tab_viewmodel.dart';
import 'package:growthdeck/views_and_viewmodels/introduction_view.dart';
import 'package:growthdeck/views_and_viewmodels/impressum_view.dart';
import 'package:growthdeck/views_and_viewmodels/MilleSandersWebView.dart';
import 'package:growthdeck/views_and_viewmodels/card_deck_selection_tab_view.dart';
import 'package:growthdeck/views_and_viewmodels/mille_sanders_tabbar_viewmodel.dart';
import 'package:growthdeck/constants/k_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MilleSandersTabBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => MilleSandersTabBarViewModel(),
        child: Consumer<MilleSandersTabBarViewModel>(
          builder: (context, model, child) => Scaffold(
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
                            color: Colors.black,
                            letterSpacing: 0.8,
                            fontSize: 21),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: model.launchFacebook,
                        child: Icon(
                          MilleSanders.facebook,
                          color: Colors.black,
                          size: 33,
                        ),
                      ),
                      GestureDetector(
                        onTap: model.launchLinkedin,
                        child: Icon(
                          MilleSanders.linkedin,
                          color: Colors.black,
                          size: 33,
                        ),
                      ),
                      GestureDetector(
                        onTap: model.launchPinterest,
                        child: Icon(
                          MilleSanders.pinterest,
                          color: Colors.black,
                          size: 33,
                        ),
                      ),
                      GestureDetector(
                        onTap: model.launchInstagram,
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
              controller: model.getPageController(),
              children: <Widget>[
                IntroductionView(),
                MilleSandersWebView('https://millesanders.com/blogs/tipps'),
                CardDeckSelectionTabView(),
                MilleSandersWebView('https://millesanders.com/'),
                ImpressumView(),
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
                      color: model.page == 0 ? Colors.black : Colors.grey,
                      onPressed: () {
                        model.jumpToPage(0);
                      },
                    ),
                    IconButton(
                      icon: Icon(MilleSanders.noun_blog),
                      color: model.page == 1 ? Colors.black : Colors.grey,
                      onPressed: () {
                        model.jumpToPage(1);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        MilleSanders.noun_overview,
                      ),
                      color: model.page == 2 ? Colors.black : Colors.grey,
                      onPressed: () {
                        model.jumpToPage(2);
                      },
                    ),
                    IconButton(
                      icon: Icon(MilleSanders.noun_info),
                      color: model.page == 3 ? Colors.black : Colors.grey,
                      onPressed: () {
                        model.jumpToPage(3);
                      },
                    ),
                    IconButton(
                      icon: Icon(MilleSanders.noun_info),
                      color: model.page == 4 ? Colors.black : Colors.grey,
                      onPressed: () {
                        model.jumpToPage(4);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

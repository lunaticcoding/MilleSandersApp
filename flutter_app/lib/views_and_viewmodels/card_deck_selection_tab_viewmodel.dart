import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/the_noun_project_icons_icons.dart';
import 'package:flutter_app/locator.dart';
import 'package:flutter_app/models/Cards.dart';

import 'card_deck_selection_tab_view.dart';
import 'card_display_view.dart';

class CardDeckSelectionTabViewModel extends ChangeNotifier {
  List<dynamic> cards;
  final _context;

  CardDeckSelectionTabViewModel(this._context) {
    locator.allReady().then((_) {
      cards = locator<Cards>().data;
      notifyListeners();
    });
  }

  void displayCardsFor({BuildContext context, dynamic deck}) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => CardDisplayView(
          deck: deck,
        ),
      ),
    );
  }

  Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  IconData getIcon(String icon) {
    switch (icon) {
      case "quotes":
        return TheNounProjectIcons.noun_quotes;
      case "tips":
        return TheNounProjectIcons.noun_tips;
      case "exit":
        return TheNounProjectIcons.noun_exit;
      case "peak":
        return TheNounProjectIcons.noun_peak;
      case "business idea":
        return TheNounProjectIcons.noun_business_idea;
      case "book":
        return TheNounProjectIcons.noun_write;
      default:
        return TheNounProjectIcons.noun_idea;
    }
  }

  List<Widget> getRowCards(dynamic cards, BoxConstraints constraints) {
    List<Widget> list = List<Widget>();
    for (int i = 0; i < cards.length; i++) {
      var card = cards[i];
      if (list.isNotEmpty) {
        list.add(SizedBox(width: 20));
      }
      list.add(
        DeckCard(
          constraints: constraints,
          color: fromHex(card["color"]),
          text: card["deckName"],
          iconData: getIcon(card["icon"]),
          onTap: () => displayCardsFor(
            context: _context,
            deck: card,
          ),
        ),
      );
    }
    return list;
  }
}

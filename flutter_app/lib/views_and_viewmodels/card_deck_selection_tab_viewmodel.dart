import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'card_display_view.dart';

class CardDeckSelectionTabViewModel {
  static void displayCardsFor({BuildContext context, String category}) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => CardDisplayView(
          category: category,
        ),
      ),
    );
  }
}

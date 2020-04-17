import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/locator.dart';
import 'package:flutter_app/models/Cards.dart';

import 'card_display_view.dart';

class CardDeckSelectionTabViewModel extends ChangeNotifier{
  final cards = locator<Cards>();

  void displayCardsFor({BuildContext context, String category}) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => CardDisplayView(
          category: category,
        ),
      ),
    );
  }
}

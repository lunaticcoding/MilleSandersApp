import 'package:flutter/cupertino.dart';
import 'package:flutter_app/constants/the_noun_project_icons_icons.dart';
import 'package:flutter_app/constants/k_colors.dart';

import 'card_detail.dart';

class Cards extends ChangeNotifier{

  final cardDeck = [
    CardDetail(
      headline: "motiviert werden",
      titleLeft: "Zitate",
      iconLeft: TheNounProjectIcons.noun_quotes,
      titleRight: "Tipps",
      iconRight: TheNounProjectIcons.noun_tips,
      color: kColors.gold,
    ),
    CardDetail(
      headline: "wachsen",
      titleLeft: "Komfortzone verlassen",
      iconLeft: TheNounProjectIcons.noun_exit,
      titleRight: "Challenges",
      iconRight: TheNounProjectIcons.noun_peak,
      color: kColors.beige,
    ),
    CardDetail(
      headline: "Ideen bekommen",
      titleLeft: "Business Ideen",
      iconLeft: TheNounProjectIcons.noun_business_idea,
      titleRight: "Journaling Prompts",
      iconRight: TheNounProjectIcons.noun_write,
      color: kColors.grey,
    ),
  ];
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/constants/the_noun_project_icons_icons.dart';
import 'package:flutter_app/constants/k_colors.dart';
import 'package:flutter_app/models/CardDetails.dart';

import 'card_category.dart';

class Cards extends ChangeNotifier {
  final cardDeck = [
    CardDetail(
      text:
          "Do the hard jobs first. The easy jobs will take care of themselves.",
      author: "Dale Carnegie",
      color: kColors.gold,
    ),
    CardDetail(
      text:
          "Productivity is being able to do things that you were never able to do before.",
      author: "Franz Kafka",
      color: kColors.beige,
    ),
    CardDetail(
      text:
          "It’s not always that we need to do more but rather that we need to focus on less.",
      author: "Nathan W. Morris",
      color: kColors.brown,
    ),
    CardDetail(
      text:
          "The tragedy in life doesn’t lie in not reaching your goal. The tragedy lies in having no goal to reach.",
      author: "Benjamin E. Mays",
      color: kColors.grey,
    ),
  ];

  final cardCategories = [
    [
      CategoryDetail(
        section: "motiviert werden",
        category: "Zitate",
        icon: TheNounProjectIcons.noun_quotes,
        color: kColors.gold,
      ),
      CategoryDetail(
        section: "motiviert werden",
        category: "Tipps",
        icon: TheNounProjectIcons.noun_tips,
        color: kColors.gold,
      ),
    ],
    [
      CategoryDetail(
        section: "wachsen",
        category: "Komfortzone verlassen",
        icon: TheNounProjectIcons.noun_quotes,
        color: kColors.gold,
      ),
      CategoryDetail(
        section: "wachsen",
        category: "Challenges",
        icon: TheNounProjectIcons.noun_tips,
        color: kColors.gold,
      ),
    ],
    [
      CategoryDetail(
        section: "Ideen bekommen",
        category: "Business Ideen",
        icon: TheNounProjectIcons.noun_exit,
        color: kColors.beige,
      ),
      CategoryDetail(
        section: "Ideen bekommen",
        category: "Journaling Prompts",
        icon: TheNounProjectIcons.noun_peak,
        color: kColors.beige,
      ),
    ],
  ];
}

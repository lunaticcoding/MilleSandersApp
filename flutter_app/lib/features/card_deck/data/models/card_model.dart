import 'package:flutter/widgets.dart';
import 'package:growthdeck/features/card_deck/domain/entities/card.dart';

class CardModel extends Card {
  CardModel(Map<String, dynamic> card)
      : super(
          text: card["text"],
          color: Color(int.parse(card['color'])),
          categories: card['categories'] as List<String>,
        );
}

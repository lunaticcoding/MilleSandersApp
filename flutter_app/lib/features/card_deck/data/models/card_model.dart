import 'package:flutter/widgets.dart';
import 'package:growthdeck/features/card_deck/domain/entities/card.dart';

class CardModel extends Card {
  final String text;
  final Color color;
  final List<String> categories;

  CardModel.fromMap(Map<String, dynamic> card)
      : text = card['text'],
        color = Color(int.parse(card['color'])),
        categories = card['categories'] as List<String>;
}

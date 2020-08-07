import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:growthdeck/constants/mille_sanders_icon_from_string.dart';
import 'package:growthdeck/features/card_deck/domain/entities/deck.dart';

class DeckModel extends Deck {
  DeckModel(Map<String, dynamic> decks)
      : super(
          name: decks['name'],
          color: Color(int.parse(decks['color'])),
          iconData: milleSandersIconFrom(decks['icon']),
          filters: decks['filters'] as List<String>,
        );
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:growthdeck/constants/mille_sanders_icon_from_string.dart';
import 'package:growthdeck/features/card_deck/domain/entities/deck.dart';

class DeckModel extends Deck {
  final String name;
  final Color color;
  final IconData icon;
  final List<String> filters;

  DeckModel.fromMap(Map<String, dynamic> decks)
      : name = decks['name'],
        color = Color(int.parse(decks['color'])),
        icon = milleSandersIconFrom(decks['icon']),
        filters = decks['filters'] as List<String>;
}

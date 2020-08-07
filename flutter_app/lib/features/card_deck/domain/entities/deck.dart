import 'package:flutter/widgets.dart';

class Deck {
  final String name;
  final IconData iconData;
  final Color color;
  final List<String> filters;
  final String cards;

  Deck({
    @required this.name,
    @required this.iconData,
    @required this.color,
    @required this.filters,
    @required this.cards,
  });
}

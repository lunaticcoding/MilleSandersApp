
import 'package:flutter/widgets.dart';

class Deck {
  final String name;
  final List<String> filters;
  final IconData icon;
  final Color color;

  Deck(
      {@required this.name,
      @required this.filters,
      @required this.icon,
      @required this.color});
}

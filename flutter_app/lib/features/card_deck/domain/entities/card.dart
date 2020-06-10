import 'dart:ui';
import 'package:meta/meta.dart';

class Card {
  final String text;
  final Color color;
  final List<String> categories;

  Card({@required this.text, @required this.color, @required this.categories});
}

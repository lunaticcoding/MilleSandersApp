import 'package:flutter/widgets.dart';

class CardModel {
  final String text;
  final Color color;
  final List<String> categories;

  CardModel(
      {@required this.text, @required this.color, @required this.categories});
}

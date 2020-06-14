
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class Deck extends Equatable {
  final String name;
  final IconData icon;
  final Color color;
  final List<String> filters;

  Deck(
      {@required this.name,
      @required this.icon,
      @required this.color,
      @required this.filters});

  @override
  List<Object> get props => [name, icon, color, filters];
}

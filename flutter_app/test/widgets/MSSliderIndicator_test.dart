import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growthdeck/widgets/MSSliderIndicator.dart';

void main() {
  int selectedIndex = 1;
  Widget widget = MaterialApp(
    home: MSSliderIndicator(
      selectedIndex: selectedIndex,
      list: [1, 2, 3, 4],
    ),
  );

  testWidgets('Has one dot less than elements in list',
      (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    final Iterable dots =
        tester.allWidgets.where((elem) => elem is DecoratedBox);

    expect(dots.length, 3);
  });

  testWidgets('Selected index dot has highlight color',
      (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    final Iterable dots =
        tester.allWidgets.where((elem) => elem is DecoratedBox);

    final DecoratedBox selectedBox =
        (dots.elementAt(selectedIndex) as DecoratedBox);
    final BoxDecoration selectedBoxDecoration =
        (selectedBox.decoration as BoxDecoration);

    expect(selectedBoxDecoration.color, Color.fromRGBO(0, 0, 0, 0.9));
  });

  testWidgets('Unselected dots have non-highlight color',
      (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    final Iterable dots =
        tester.allWidgets.where((elem) => elem is DecoratedBox);

    for (int i = 0; i < dots.length; i++) {
      if (i != selectedIndex) {
        final DecoratedBox unselectedBox = (dots.elementAt(i) as DecoratedBox);
        final BoxDecoration unselectedBoxDecoration =
            (unselectedBox.decoration as BoxDecoration);
        expect(unselectedBoxDecoration.color, Color.fromRGBO(0, 0, 0, 0.4));
      }
    }
  });
}

import 'package:flutter/material.dart';
import 'package:growthdeck/views_and_viewmodels/card_display_viewmodel.dart';
import 'package:provider/provider.dart';

import 'MSCard.dart';

class MSCardStack extends StatefulWidget {
  @override
  _MSCardStackState createState() => _MSCardStackState();
}

class _MSCardStackState extends State<MSCardStack> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CardDisplayViewModel>(
      builder: (context, model, child) => Stack(
        overflow: Overflow.visible,
        children: model.getNrValidCards() > 0
            ? model.forEachCard(
                (isFirstCard, card) {
                  if (isFirstCard) {
                    return _ActiveCard(
                      text: card.text,
                      color: card.color,
                      onDragEnd: (_) => model.removeCard(),
                      animationRotation: model.animationRotation,
                      animationTranslation: model.animationTranslation,
                    );
                  } else {
                    return _StaticCard(
                      text: card.text,
                      color: card.color,
                      elevation: isFirstCard ? 6 : 0,
                    );
                  }
                },
              )
            : <Widget>[
                _NoCard(
                  onTap: model.updateFilter,
                ),
              ],
      ),
    );
  }
}

class _ActiveCard extends StatefulWidget {
  _ActiveCard({
    this.onDragEnd,
    this.color,
    this.text,
    this.animationTranslation,
    this.animationRotation,
  });

  final onDragEnd;
  final color;
  final text;
  final animationTranslation;
  final animationRotation;

  @override
  _ActiveCardState createState() => _ActiveCardState();
}

class _ActiveCardState extends State<_ActiveCard> {
  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.animationTranslation.value.dx,
      bottom: widget.animationTranslation.value.dy,
      child: Transform.rotate(
        angle: widget.animationRotation.value,
        child: Draggable(
          onDragEnd: widget.onDragEnd,
          childWhenDragging: Container(
            width: 265,
            height: 350,
          ),
          feedback: TweenAnimationBuilder(
            tween: Tween<double>(begin: 10, end: 0),
            duration: Duration(milliseconds: 400),
            builder: (context, value, child) => MSCard(
              text: widget.text,
              color: widget.color,
            ),
          ),
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 15, end: 0),
            duration: Duration(milliseconds: 400),
            builder: (BuildContext context, double value, Widget child) =>
                Padding(
              padding: EdgeInsets.fromLTRB(value, value, 0, value),
              child: RepaintBoundary(
                key: key,
                child: MSCard(
                  text: widget.text,
                  color: widget.color,
                  height: 350 - 2 * value,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StaticCard extends StatelessWidget {
  const _StaticCard({this.color, this.text, this.elevation});

  final color;
  final text;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
        child: MSCard(
          text: text,
          color: color,
        ));
  }
}

class _NoCard extends StatelessWidget {
  const _NoCard({this.onTap});
  final onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 265,
        height: 350,
        child: Center(
          child: Text(
            "Tap to shuffle the deck.",
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }
}

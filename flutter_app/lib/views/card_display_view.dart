import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:growthdeck/constants/k_colors.dart';
import 'package:growthdeck/constants/mille_sanders_icons.dart';
import 'package:growthdeck/widgets/MSCard.dart';
import 'package:growthdeck/widgets/MSRoundedIconButton.dart';
import 'package:growthdeck/widgets/MSProgressIndicator.dart';
import 'package:growthdeck/widgets/MSSpeechBubbleTick.dart';
import 'package:growthdeck/models/Decks.dart';
import 'package:growthdeck/viewmodels/card_display_viewmodel.dart';
import 'package:provider/provider.dart';

import '../viewmodels/card_display_viewmodel.dart';

class CardDisplayView extends StatefulWidget {
  @override
  _CardDisplayViewState createState() => _CardDisplayViewState();
}

class _CardDisplayViewState extends State<CardDisplayView>
    with SingleTickerProviderStateMixin {
  GlobalKey filterKey;

  @override
  void initState() {
    super.initState();
    filterKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProxyProvider<Decks, CardDisplayViewModel>(
        create: (context) => CardDisplayViewModel(this),
        update: (context, decks, model) =>
            model..initWithSelectedDeck(decks.selectedDeck),
        child: Consumer<CardDisplayViewModel>(
          builder: (context, model, child) => model.isReady
              ? Container(
                  color: Colors.white,
                  child: Center(
                    child: Container(
                      width: 280,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            model.deckName,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10),
                          _MSCardStack(),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              MSRoundedIconButton(
                                icon: MilleSanders.arrowleft,
                                color: kColors.brown,
                                onTap: model.animateToPrevCard,
                              ),
                              Container(
                                child: MSRoundedIconButton(
                                  icon: MilleSanders.random,
                                  color: kColors.beige,
                                  onTap: model.shuffleDeck,
                                ),
                              ),
                              Container(
                                key: filterKey,
                                child: MSRoundedIconButton(
                                  icon: MilleSanders.noun_filters,
                                  color: kColors.grey,
                                  onTap: () => _showModalPopup(model),
                                ),
                              ),
                              MSRoundedIconButton(
                                icon: MilleSanders.arrowright,
                                color: kColors.gold,
                                onTap: model.animateToNextCard,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : MSProgressIndicator(),
        ),
      );

  Future _showModalPopup(CardDisplayViewModel model) => showCupertinoModalPopup(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => Padding(
            padding: EdgeInsets.fromLTRB(
                0,
                0,
                0,
                MediaQuery.of(context).size.height -
                    (filterKey.currentContext.findRenderObject() as RenderBox)
                        .localToGlobal(Offset.zero)
                        .dy),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  width: 300,
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: model.filters.entries
                        .map<Widget>(
                          (filter) => GestureDetector(
                            onTap: () {
                              setState(() {
                                model.filters[filter.key] = !filter.value;
                              });
                              model.updateFilter();
                            },
                            child: Icon(
                              Decks.getIcon(filter.key),
                              color: model.filters[filter.key]
                                  ? kColors.gold
                                  : kColors.grey,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 15,
                  child: CustomPaint(
                    painter: MSSpeechBubbleTick(
                      x: (filterKey.currentContext.findRenderObject()
                              as RenderBox)
                          .localToGlobal(Offset.zero)
                          .dx,
                      y: 0,
                      width: (filterKey.currentContext.findRenderObject()
                              as RenderBox)
                          .size
                          .width,
                      height: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class _MSCardStack extends StatefulWidget {
  _MSCardStack({this.width = 280, this.height = 350});

  final double width;
  final double height;

  @override
  _MSCardStackState createState() => _MSCardStackState();
}

class _MSCardStackState extends State<_MSCardStack> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CardDisplayViewModel>(
      builder: (context, model, child) => Container(
        width: widget.width,
        height: widget.height,
        child: Stack(
          overflow: Overflow.visible,
          children: model.getNrValidCards() > 0
              ? model.forEachCard(
                  (index, card) {
                    if (index == 0) {
                      return _ActiveCard(
                        text: card.text,
                        color: card.color,
                        onDragEnd: (_) => model.removeCard(),
                        animationRotation: model.animationRotation,
                        animationTranslation: model.animationTranslation,
                        elevation: 6,
                      );
                    } else {
                      return _StaticCard(
                        text: card.text,
                        color: card.color,
                        elevation: index == model.getNrValidCards() - 1 ? 6 : 0,
                      );
                    }
                  },
                )
              : <Widget>[
                  _NoCard(
                    onTap: model.shuffleDeck,
                  ),
                ],
        ),
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
    this.elevation = 6,
  });

  final Function onDragEnd;
  final Color color;
  final String text;
  final Animation animationTranslation;
  final Animation animationRotation;
  final double elevation;

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
          elevation: elevation,
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

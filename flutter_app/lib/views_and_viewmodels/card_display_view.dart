import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:growthdeck/constants/k_colors.dart';
import 'package:growthdeck/constants/mille_sanders_icons.dart';
import 'package:growthdeck/custom_widgets/TrianglePainter.dart';
import 'package:growthdeck/custom_widgets/card.dart';
import 'package:growthdeck/models/Cards.dart';
import 'package:growthdeck/views_and_viewmodels/card_display_viewmodel.dart';
import 'package:provider/provider.dart';

class CardDisplayView extends StatefulWidget {
  CardDisplayView({this.deck});
  final dynamic deck;

  @override
  _CardDisplayViewState createState() => _CardDisplayViewState();
}

class _CardDisplayViewState extends State<CardDisplayView>
    with SingleTickerProviderStateMixin {
  GlobalKey filterKey;
  AnimationController _animationController;
  Animation _animationTranslation;
  Animation _animationRotation;

  @override
  void initState() {
    super.initState();
    filterKey = GlobalKey();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _animationTranslation = new Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(200, 50),
    ).animate(_animationController)
      ..addListener(
        () {
          setState(() {});
        },
      );
    _animationRotation = new Tween<double>(
      begin: 0,
      end: 0.2,
    ).animate(_animationController)
      ..addListener(
        () {
          setState(() {});
        },
      );
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => CardDisplayViewmodel(widget.deck),
        child: Consumer<CardDisplayViewmodel>(
          builder: (BuildContext context, CardDisplayViewmodel model,
                  Widget child) =>
              model.isReady
                  ? Container(
                      color: Colors.white,
                      child: Center(
                        child: Container(
                          width: 280,
                          color: Colors.white,
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
                              Container(
                                width: 280,
                                height: 350,
                                child: Stack(
                                  overflow: Overflow.visible,
                                  children: model.getNrValidCards() > 0
                                      ? model.forEachCard(
                                          (isFirstCard, card) {
                                            if (isFirstCard) {
                                              return ActiveCard(
                                                text: card["text"],
                                                color: Cards.colorFromHex(
                                                    card["color"]),
                                                onDragEnd: (_) {
                                                  model.removeCard();
                                                  setState(() {});
                                                },
                                                animationRotation:
                                                    _animationRotation,
                                                animationTranslation:
                                                    _animationTranslation,
                                              );
                                            } else {
                                              return OtherCard(
                                                text: card["text"],
                                                color: Cards.colorFromHex(
                                                    card["color"]),
                                                elevation: isFirstCard ? 6 : 0,
                                              );
                                            }
                                          },
                                        )
                                      : <Widget>[
                                          NoCard(onTap: () {
                                            model.updateFilter();
                                          }),
                                        ],
                                ),
                              ),
                              SizedBox(height: 30),
                              Container(
                                width: 300,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () async {
                                        if (model.addCard()) {
                                          await _animationController.reverse(
                                              from: 1.0);
                                        }
                                      },
                                      child: DisplayCard(
                                        width: 60,
                                        elevation: 0,
                                        color: kColors.brown,
                                        child: Icon(
                                          MilleSanders.arrowleft,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: Navigator.of(context).pop,
                                      child: DisplayCard(
                                        width: 60,
                                        elevation: 0,
                                        color: kColors.grey,
                                        child: Icon(
                                          MilleSanders.noun_overview,
                                          size: 35,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => showCupertinoModalPopup(
                                        context: context,
                                        builder: (context) => StatefulBuilder(
                                          builder: (context, setState) =>
                                              Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0,
                                                0,
                                                0,
                                                MediaQuery.of(context)
                                                        .size
                                                        .height -
                                                    (filterKey.currentContext
                                                                .findRenderObject()
                                                            as RenderBox)
                                                        .localToGlobal(
                                                            Offset.zero)
                                                        .dy),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: Colors.white,
                                                  ),
                                                  width: 300,
                                                  height: 55,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: model
                                                        .filters.entries
                                                        .map<Widget>(
                                                          (filter) =>
                                                              GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                model.filters[
                                                                        filter
                                                                            .key] =
                                                                    !filter
                                                                        .value;
                                                              });
                                                              model
                                                                  .updateFilter();
                                                            },
                                                            child: Icon(
                                                              Cards.getIcon(
                                                                  filter.key),
                                                              color: model.filters[
                                                                      filter
                                                                          .key]
                                                                  ? kColors.gold
                                                                  : kColors
                                                                      .grey,
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 15,
                                                  child: CustomPaint(
                                                    painter: TrianglePainter(
                                                      x: (filterKey
                                                                  .currentContext
                                                                  .findRenderObject()
                                                              as RenderBox)
                                                          .localToGlobal(
                                                              Offset.zero)
                                                          .dx,
                                                      y: 0,
                                                      width: (filterKey
                                                                  .currentContext
                                                                  .findRenderObject()
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
                                      ),
                                      child: Container(
                                        key: filterKey,
                                        child: DisplayCard(
                                          width: 60,
                                          elevation: 0,
                                          color: kColors.beige,
                                          child: Icon(
                                            MilleSanders.noun_filters,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (model.removeCard()) {
                                          await _animationController.forward();
                                          _animationController.reset();
                                        }
                                      },
                                      child: DisplayCard(
                                        width: 60,
                                        elevation: 0,
                                        color: kColors.gold,
                                        child: Icon(
                                          MilleSanders.arrowright,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kColors.gold),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
        ),
      );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class ActiveCard extends StatefulWidget {
  ActiveCard({
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

class _ActiveCardState extends State<ActiveCard> {
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
            builder: (context, value, child) => DisplayCard(
              width: 265,
              height: 350,
              color: widget.color,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.text,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                child: DisplayCard(
                  width: 265,
                  height: 350 - 2 * value,
                  color: widget.color,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.text,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OtherCard extends StatelessWidget {
  const OtherCard({this.color, this.text, this.elevation});

  final color;
  final text;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
      child: DisplayCard(
        width: 265,
        height: 320,
        color: color,
        elevation: elevation,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NoCard extends StatelessWidget {
  const NoCard({this.onTap});
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

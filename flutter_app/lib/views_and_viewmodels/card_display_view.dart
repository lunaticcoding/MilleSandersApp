import 'package:flutter/material.dart';
import 'package:flutter_app/constants/k_colors.dart';
import 'package:flutter_app/constants/the_noun_project_icons_icons.dart';
import 'package:flutter_app/custom_widgets/card.dart';
import 'package:flutter_app/views_and_viewmodels/card_display_viewmodel.dart';
import 'package:provider_architecture/provider_architecture.dart';

class CardDisplayView extends StatefulWidget {
  CardDisplayView({this.deck});
  final dynamic deck;

  @override
  _CardDisplayViewState createState() => _CardDisplayViewState();
}

class _CardDisplayViewState extends State<CardDisplayView>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animationTranslation;
  Animation _animationRotation;

  @override
  void initState() {
    super.initState();
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
  Widget build(BuildContext context) => ViewModelProvider.withConsumer(
        viewModel: CardDisplayViewmodel(_animationController,
            _animationTranslation, _animationRotation, widget.deck),
        builder: (context, model, widget) => model.cardDeck != null
            ? Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      model.cardDeck["deckName"],
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Stack(
                      overflow: Overflow.visible,
                      children: model.getCardDeck(),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: model.prevCard,
                            child: DisplayCard(
                              width: 60,
                              elevation: 0,
                              color: kColors.brown,
                              child: Icon(
                                TheNounProjectIcons.noun_arrows_left,
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
                                TheNounProjectIcons.noun_overview,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DisplayCard(
                            width: 60,
                            elevation: 0,
                            color: kColors.beige,
                            child: Icon(
                              TheNounProjectIcons.noun_bookmark,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: model.nextCard,
                            child: DisplayCard(
                              width: 60,
                              elevation: 0,
                              color: kColors.gold,
                              child: Icon(
                                TheNounProjectIcons.noun_arrows_right,
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
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class FirstCard extends StatefulWidget {
  FirstCard(
      {this.onDragEnd,
      this.color,
      this.text,
      this.animationTranslation,
      this.animationRotation});

  final onDragEnd;
  final color;
  final text;
  final animationTranslation;
  final animationRotation;

  @override
  _FirstCardState createState() => _FirstCardState();
}

class _FirstCardState extends State<FirstCard> {
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
            width: 300,
            height: 400,
          ),
          feedback: TweenAnimationBuilder(
            tween: Tween<double>(begin: 10, end: 0),
            duration: Duration(milliseconds: 400),
            builder: (context, value, child) => DisplayCard(
              width: 300,
              height: 400,
              color: widget.color,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        TheNounProjectIcons.noun_share,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  Center(
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
                ],
              ),
            ),
          ),
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 15, end: 0),
            duration: Duration(milliseconds: 400),
            builder: (BuildContext context, double value, Widget child) =>
                Padding(
              padding: EdgeInsets.fromLTRB(value, value, 0, value),
              child: DisplayCard(
                width: 300,
                height: 400 - 2 * value,
                color: widget.color,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          TheNounProjectIcons.noun_share,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    Center(
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SecondCard extends StatelessWidget {
  const SecondCard({this.color, this.text, this.elevation});

  final color;
  final text;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
      child: DisplayCard(
        width: 300,
        height: 370,
        color: color,
        elevation: elevation,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                TheNounProjectIcons.noun_share,
                color: Colors.white,
                size: 30,
              ),
            ),
            Center(
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
          ],
        ),
      ),
    );
  }
}

class LastCard extends StatelessWidget {
  const LastCard({this.onTap});
  final onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 400,
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

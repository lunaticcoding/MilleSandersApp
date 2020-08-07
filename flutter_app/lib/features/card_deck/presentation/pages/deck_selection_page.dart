import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:growthdeck/models/Decks.dart';
import 'package:growthdeck/services/navigation_service.dart';
import 'package:growthdeck/widgets/MSProgressIndicator.dart';
import 'package:growthdeck/widgets/MSRoundedSquare.dart';
import 'package:growthdeck/widgets/MSSliderIndicator.dart';
import 'package:provider/provider.dart';

class DeckSelectionPage extends StatefulWidget {
  @override
  _DeckSelectionPageState createState() => _DeckSelectionPageState();
}

class _DeckSelectionPageState extends State<DeckSelectionPage> {
  @override
  Widget build(BuildContext context) => Consumer<Decks>(
        builder: (context, Decks decks, Widget child) => decks.hasData
            ? decks.cardSections != null
                ? Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 20),
                          Text(
                            "Heute möchte ich...",
                            style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.black,
                              decorationStyle: TextDecorationStyle.solid,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                          SectionList(
                              sectionNames: decks.cardSections
                                  .map((section) => section.name)
                                  .toList()),
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: decks.reloadData,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Text(
                          decks.error,
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  )
            : MSProgressIndicator(),
      );
}

class SectionList extends StatelessWidget {
  SectionList({this.sectionNames});
  final List<String> sectionNames;

  @override
  Widget build(BuildContext context) {
    return Consumer<Decks>(
      builder: (context, Decks decks, Widget child) => Flexible(
        child: ListView.builder(
          itemCount: sectionNames.length,
          itemBuilder: (BuildContext ctxt, int index) => Column(
            children: <Widget>[
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) =>
                    Container(
                  width: constraints.maxWidth,
                  child: Text(
                    sectionNames[index],
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              CardDeckList(section: decks.cardSections[index]),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class CardDeckList extends StatefulWidget {
  CardDeckList({this.section});
  final CardSection section;

  @override
  _CardDeckListState createState() => _CardDeckListState();
}

class _CardDeckListState extends State<CardDeckList> {
  ScrollController scrollController = ScrollController();
  int sliderIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer2<Decks, NavigationService>(
      builder: (
        context,
        Decks decks,
        NavigationService navService,
        Widget child,
      ) =>
          LayoutBuilder(
        builder: (context, constraints) => decks.hasData
            ? decks.cardSections != null
                ? Column(
                    children: <Widget>[
                      Container(
                        width: constraints.maxWidth,
                        height: constraints.maxWidth / 2 - 10,
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (notification) =>
                              onNotification(notification, constraints),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            controller: scrollController,
                            itemCount: widget.section.cardDecks.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 20),
                            itemBuilder: (context, i) {
                              CardDeck cardDeck = widget.section.cardDecks[i];
                              return DeckCard(
                                constraints: constraints,
                                color: cardDeck.color,
                                text: cardDeck.name,
                                iconData: cardDeck.icon,
                                onTap: () {
                                  decks.setSelectedDeck(cardDeck);
                                  navService.jumpToPage(5);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      MSSliderIndicator(
                        list: widget.section.cardDecks,
                        selectedIndex: sliderIndex,
                      ),
                    ],
                  )
                : Center(
                    child: Text(decks.error),
                  )
            : MSProgressIndicator(),
      ),
    );
  }

  bool onNotification(
    ScrollNotification notification,
    BoxConstraints constraints,
  ) {
    double cardSize = constraints.maxWidth / 2 + 10;
    if (notification is ScrollUpdateNotification) {
      double offset = scrollController.offset;
      sliderIndex = offset < 0
          ? 0
          : offset ~/ cardSize + ((offset % cardSize > (cardSize / 2)) ? 1 : 0);
    } else if (notification is ScrollEndNotification) {
      Future.delayed(Duration(microseconds: 1), () {
        double target = sliderIndex * cardSize;
        scrollController.animateTo(target,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    }
    return true;
  }
}

class DeckCard extends StatelessWidget {
  DeckCard(
      {this.constraints, this.color, this.text, this.iconData, this.onTap});
  final BoxConstraints constraints;
  final Color color;
  final String text;
  final IconData iconData;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return MSRoundedSquare(
      elevation: 0,
      width: constraints.maxWidth / 2 - 10,
      color: color,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 10),
          Icon(
            iconData,
            size: 80,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

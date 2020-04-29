import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:growthdeck/models/Cards.dart';
import 'package:growthdeck/services/navigation_service.dart';
import 'package:growthdeck/widgets/MSProgressIndicator.dart';
import 'package:growthdeck/widgets/MSRoundedSquare.dart';
import 'package:provider/provider.dart';

class DeckSelectionView extends StatefulWidget {
  @override
  _DeckSelectionViewState createState() =>
      _DeckSelectionViewState();
}

class _DeckSelectionViewState extends State<DeckSelectionView> {
  List<int> indices;
  List<ScrollController> scrollControllerList;

  @override
  void initState() {
    indices = List<int>();
    scrollControllerList = List<ScrollController>();

//    for (var _ in Provider.of<Cards>(context, listen: false).cardSections) {
    for (int i = 0; i < 2; i++) {
      scrollControllerList.add(ScrollController());
      indices.add(0);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Consumer2<NavigationService, Cards>(
        builder: (context, navigationService, cards, child) =>
            cards?.isLoading ?? true
                ? MSProgressIndicator()
                : cards.error == null
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
                              _SectionList(
                                  sectionNames: cards.cardSections
                                      .map((section) => section.name)),
                            ],
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: cards.reloadData,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Text(
                              cards.error,
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
      );
}

class _SectionList extends StatelessWidget {
  _SectionList({this.sectionNames});
  final List<String> sectionNames;

  @override
  Widget build(BuildContext context) {
    return Flexible(
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
            _CardDeckList(index),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _CardDeckList extends StatefulWidget {
  _CardDeckList(this.index);
  final int index;

  @override
  __CardDeckListState createState() => __CardDeckListState();
}

class __CardDeckListState extends State<_CardDeckList> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DeckSelectionViewModel>(
      create: (BuildContext context) => DeckSelectionViewModel(),
      child: Consumer2<NavigationService, Cards>(
        builder: (context, navigationService, cards, child) => LayoutBuilder(
          builder: (context, constraints) => Column(
            children: <Widget>[
              Container(
                width: constraints.maxWidth,
                height: constraints.maxWidth / 2 - 10,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    double cardSize = constraints.maxWidth / 2 + 10;
                    if (notification is ScrollUpdateNotification) {
                      int cardIndex;
                      if (scrollControllerList[index].offset < 0) {
                        cardIndex = 0;
                      } else {
                        double offset = scrollControllerList[index].offset;
                        cardIndex = offset ~/ cardSize +
                            ((offset % cardSize > (cardSize / 2)) ? 1 : 0);
                      }
                      indices[index] = cardIndex;
                      setState(() {});
                    }
                    if (notification is ScrollEndNotification) {
                      Future.delayed(Duration(microseconds: 1), () {
                        double target = indices[index] * cardSize;
                        scrollControllerList[index].animateTo(target,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut);
                      });
                    }
                    return true;
                  },
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    controller: scrollControllerList[index],
                    itemCount: cards.cardSections[index].cardDecks.length,
                    separatorBuilder: (context, index) => SizedBox(width: 20),
                    itemBuilder: (context, i) {
                      CardDeck cardDeck = cards.cardSections[index].cardDecks[i];
                      return DeckCard(
                        constraints: constraints,
                        color: cardDeck.color,
                        text: cardDeck.name,
                        iconData: cardDeck.icon,
                        onTap: () {
                          cards.setSelectedDeck(cardDeck);
                          navigationService.jumpToPage(5);
                        },
                      );
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: cards.cardSections[index].cardDecks
                    .sublist(0, cards.cardSections[index].cardDecks.length - 1)
                    .map<Widget>((card) {
                  int i = cards.cardSections[index].cardDecks.indexOf(card);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i == indices[index]
                          ? Color.fromRGBO(0, 0, 0, 0.9)
                          : Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
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

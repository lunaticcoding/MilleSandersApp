import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:growthdeck/models/Cards.dart';
import 'package:growthdeck/services/navigation_service.dart';
import 'package:growthdeck/widgets/MSProgressIndicator.dart';
import 'package:growthdeck/widgets/MSRoundedSquare.dart';
import 'package:growthdeck/widgets/MSSliderIndicator.dart';
import 'package:provider/provider.dart';

import 'deck_selection_viewmodel.dart';

class DeckSelectionView extends StatefulWidget {
  @override
  _DeckSelectionViewState createState() => _DeckSelectionViewState();
}

class _DeckSelectionViewState extends State<DeckSelectionView> {
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
                                      .map((section) => section.name)
                                      .toList()),
                            ],
                          ),
                        ),
                      )
                    : GestureDetector(
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
    return ChangeNotifierProxyProvider<Cards, DeckSelectionViewModel>(
      create: (BuildContext context) => DeckSelectionViewModel(),
      update: (BuildContext context, cards, model) =>
          model..initWithSections(cards?.cardSections),
      child: Consumer3<NavigationService, DeckSelectionViewModel, Cards>(
        builder: (context, navigationService, model, cards, child) =>
            LayoutBuilder(
          builder: (context, constraints) => model.isLoading
              ? MSProgressIndicator()
              : Column(
                  children: <Widget>[
                    Container(
                      width: constraints.maxWidth,
                      height: constraints.maxWidth / 2 - 10,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (notification) => model.onNotification(
                            notification, constraints, widget.index),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          controller: model.scrollControllers[widget.index],
                          itemCount:
                              model.cardSections[widget.index].cardDecks.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 20),
                          itemBuilder: (context, i) {
                            CardDeck cardDeck =
                                model.cardSections[widget.index].cardDecks[i];
                            return _DeckCard(
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
                    MSSliderIndicator(
                      cardDecks: model.cardSections[widget.index].cardDecks,
                      selectedIndex: model.indices[widget.index],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _DeckCard extends StatelessWidget {
  _DeckCard(
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

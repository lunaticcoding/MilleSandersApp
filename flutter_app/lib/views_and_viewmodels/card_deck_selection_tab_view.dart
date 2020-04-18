import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widgets/card.dart';
import 'package:flutter_app/locator.dart';
import 'package:flutter_app/models/Cards.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

import 'card_deck_selection_tab_viewmodel.dart';
import 'card_display_view.dart';

class CardDeckSelectionTabView extends StatefulWidget {
  @override
  _CardDeckSelectionTabViewState createState() =>
      _CardDeckSelectionTabViewState();
}

class _CardDeckSelectionTabViewState extends State<CardDeckSelectionTabView> {
  List<ScrollController> _scrollControllerList;
  List<int> _indices;
  ScrollController _scrollController;
  double width = 0;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollControllerList = List<ScrollController>();
    _indices = List<int>();
    locator.isReady<Cards>().then((_) {
      for (_ in locator<Cards>().data) {
        _scrollControllerList.add(ScrollController());
        _indices.add(0);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      viewModel: CardDeckSelectionTabViewModel(),
      builder: (context, model, widget) {
        width = (MediaQuery.of(context).size.width - 40) / 2 + 10;
        return model.cards != null
            ? model.error == null
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
                          Flexible(
                            child: ListView.builder(
                              itemCount: model.cards.length,
                              itemBuilder: (BuildContext ctxt, int index) =>
                                  Column(
                                children: <Widget>[
                                  LayoutBuilder(
                                    builder: (BuildContext context,
                                            BoxConstraints constraints) =>
                                        Container(
                                      width: constraints.maxWidth,
                                      child: Text(
                                        model.cards[index]["sectionName"],
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
                                  LayoutBuilder(
                                    builder: (context, constraints) => Column(
                                      children: <Widget>[
                                        Container(
                                          width: constraints.maxWidth,
                                          height: constraints.maxWidth / 2 - 10,
                                          child: NotificationListener<
                                              ScrollNotification>(
                                            onNotification: (notification) {
                                              if (notification
                                                  is ScrollEndNotification) {
                                                Future.delayed(
                                                    Duration(milliseconds: 1),
                                                    () {
                                                  double cardSize =
                                                      constraints.maxWidth / 2 +
                                                          10;
                                                  double offset =
                                                      _scrollControllerList[index].offset;
                                                  int cardIndex = offset ~/
                                                      cardSize + ((offset % cardSize >
                                                      (cardSize /
                                                          2))
                                                      ? 1
                                                      : 0);
                                                  setState(() {
                                                    _indices[index] = cardIndex;
                                                  });
                                                  double target = cardIndex * cardSize;
                                                  _scrollControllerList[index].animateTo(
                                                      target,
                                                      duration: Duration(
                                                          milliseconds: 300),
                                                      curve: Curves.easeOut);
                                                });
                                              }
                                              return true;
                                            },
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              controller: _scrollControllerList[index],
                                              children: model.getRowCards(
                                                  model.cards[index]["decks"],
                                                  constraints),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: model.cards[index]["decks"]
                                              .sublist(
                                                  0,
                                                  model.cards[index]["decks"]
                                                          .length -
                                                      1)
                                              .map<Widget>((card) {
                                                int i = model.cards[index]["decks"].indexOf(card);
                                            return Container(
                                              width: 8.0,
                                              height: 8.0,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 2.0),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: i == _indices[index]
                                                    ? Color.fromRGBO(
                                                        0, 0, 0, 0.9)
                                                    : Color.fromRGBO(
                                                        0, 0, 0, 0.4),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: model.reload,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Text(
                          model.error,
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  @override
  void dispose() {
    _scrollControllerList.forEach((controller) => controller.dispose());
    super.dispose();
  }
}

class DeckCard extends StatelessWidget {
  DeckCard({this.constraints, this.color, this.deck, this.text, this.iconData});
  final BoxConstraints constraints;
  final Color color;
  final String text;
  final IconData iconData;
  final dynamic deck;

  @override
  Widget build(BuildContext context) {
    return DisplayCard(
      elevation: 0,
      width: constraints.maxWidth / 2 - 10,
      color: color,
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => CardDisplayView(
            deck: deck,
          ),
        ),
      ),
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

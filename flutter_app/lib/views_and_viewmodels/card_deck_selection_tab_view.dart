import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widgets/card.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

import 'card_deck_selection_tab_viewmodel.dart';

class CardDeckSelectionTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      viewModel: CardDeckSelectionTabViewModel(context),
      builder: (context, model, widget) => model.cards != null
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
                                  builder: (context, constraints) => Container(
                                    width: constraints.maxWidth,
                                    child: Container(
                                      width: constraints.maxWidth,
                                      height: constraints.maxWidth / 2 - 10,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: model.getRowCards(
                                            model.cards[index]["decks"],
                                            constraints),
                                      ),
                                    ),
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
              : Center(
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
                )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class DeckCard extends StatelessWidget {
  DeckCard(
      {this.constraints, this.color, this.onTap, this.text, this.iconData});
  final BoxConstraints constraints;
  final Color color;
  final Function onTap;
  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return DisplayCard(
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

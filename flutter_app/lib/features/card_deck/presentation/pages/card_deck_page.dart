import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growthdeck/features/card_deck/domain/entities/deck.dart';
import 'package:growthdeck/features/card_deck/domain/entities/section.dart';
import 'package:growthdeck/features/card_deck/presentation/bloc/card_deck_bloc.dart';
import 'package:growthdeck/widgets/MSProgressIndicator.dart';
import 'package:growthdeck/widgets/MSRoundedSquare.dart';
import 'package:growthdeck/widgets/MSSliderIndicator.dart';

class CardDeckPage extends StatefulWidget {
  @override
  _CardDeckPageState createState() => _CardDeckPageState();
}

class _CardDeckPageState extends State<CardDeckPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CardDeckBloc>(
      lazy: false,
      create: (BuildContext context) => CardDeckBloc(CardDeckState.loading()),
      child: Builder(
        builder: (context) => context.bloc<CardDeckBloc>().state.map(
              loading: (Loading _) => MSProgressIndicator(),
              sectionState: (SectionState state) => Container(
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
                      SectionList(),
                    ],
                  ),
                ),
              ),
              error: (Error error) => GestureDetector(
                onTap: () =>
                    context.bloc<CardDeckBloc>().add(CardDeckEvent.loadData()),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Text(
                      // TODO add error string to display to the user
                      error.toString(),
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              deckState: (DeckState value) {},
            ),
      ),
    );
  }
}

class SectionList extends StatelessWidget {
  SectionList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardDeckBloc, CardDeckState>(
      builder: (context, state) => state.maybeMap(
        sectionState: (SectionState state) => Flexible(
          child: ListView.builder(
            itemCount: state.sections.length,
            itemBuilder: (BuildContext ctxt, int index) => Column(
              children: <Widget>[
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) =>
                      Container(
                    width: constraints.maxWidth,
                    child: Text(
                      state.sections[index].name,
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
                CardDeckList(section: state.sections[index]),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        orElse: () => throw Exception(),
      ),
    );
  }
}

class CardDeckList extends StatefulWidget {
  CardDeckList({this.section});
  final Section section;

  @override
  _CardDeckListState createState() => _CardDeckListState();
}

// FIXME fix this!!!
class _CardDeckListState extends State<CardDeckList> {
  ScrollController scrollController = ScrollController();
  int sliderIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
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
                itemCount: widget.section.decks.length,
                separatorBuilder: (context, index) => SizedBox(width: 20),
                itemBuilder: (context, i) {
                  Deck deck = widget.section.decks[i];
//                  CardDeck cardDeck = widget.section.decks.cards[i];
                  return DeckCard(
                    constraints: constraints,
                    color: deck.color,
                    text: deck.name,
                    iconData: deck.iconData,
                    onTap: () {
                      // TODO change state!
//                      decks.setSelectedDeck(cardDeck);
//                      navService.jumpToPage(5);
                    },
                  );
                },
              ),
            ),
          ),
          MSSliderIndicator(
            list: widget.section.decks,
            selectedIndex: sliderIndex,
          ),
        ],
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

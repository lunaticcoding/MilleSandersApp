import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:growthdeck/constants/k_colors.dart';
import 'package:growthdeck/constants/mille_sanders_icons.dart';
import 'package:growthdeck/widgets/MSRoundedIconButton.dart';
import 'package:growthdeck/widgets/MSProgressIndicator.dart';
import 'package:growthdeck/widgets/MSSpeechBubbleTick.dart';
import 'package:growthdeck/models/Cards.dart';
import 'package:growthdeck/views_and_viewmodels/card_display_viewmodel.dart';
import 'package:growthdeck/widgets/MSCardStack.dart';
import 'package:provider/provider.dart';

import 'card_display_viewmodel.dart';

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
      ChangeNotifierProxyProvider<Cards, CardDisplayViewModel>(
        create: (context) => CardDisplayViewModel(this),
        update: (context, cards, model) =>
            model..initWithSelectedDeck(cards.selectedDeck),
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
                          Container(
                            width: 280,
                            height: 350,
                            child: MSCardStack(),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              MSRoundedIconButton(
                                icon: MilleSanders.arrowleft,
                                color: kColors.brown,
                                onTap: model.animateToNextCard,
                              ),
                              SizedBox(width: 20),
                              MSRoundedIconButton(
                                icon: MilleSanders.noun_filters,
                                color: kColors.grey,
                                onTap: _shoModalPopup,
                              ),
                              SizedBox(width: 20),
                              MSRoundedIconButton(
                                icon: MilleSanders.arrowright,
                                color: kColors.gold,
                                onTap: model.animateToPrevCard,
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

  Future _shoModalPopup() => showCupertinoModalPopup(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => Consumer<CardDisplayViewModel>(
            builder: (context, model, child) => Padding(
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
                                Cards.getIcon(filter.key),
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
        ),
      );
}

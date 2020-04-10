import 'package:flutter/material.dart';
import 'package:flutter_app/views_and_viewmodels/card_deck_selection_tab_viewmodel.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

class CardDeckSelectionTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      viewModel: CardDeckSelectionTabViewModel(),
      builder: (context, model, child) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              "Heute möchte ich...",
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Flexible(
              child: ListView.builder(
                itemCount: model.cardDetails.length,
                itemBuilder: (BuildContext ctxt, int index) => Column(
                  children: <Widget>[
                    LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) =>
                              Container(
                        width: constraints.maxWidth,
                        child: Text(
                          model.cardDetails[index].headline,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Card(
                          size: 170,
                          text: model.cardDetails[index].titleLeft,
                          color: model.cardDetails[index].color,
                          icon: model.cardDetails[index].iconLeft,
                        ),
                        Card(
                          size: 170,
                          text: model.cardDetails[index].titleRight,
                          color: model.cardDetails[index].color,
                          icon: model.cardDetails[index].iconRight,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
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

class Card extends StatelessWidget {
  final double size;
  final String text;
  final IconData icon;
  final Color color;
  Card({@required this.size, this.text, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 10),
          Icon(
            icon,
            size: 80,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

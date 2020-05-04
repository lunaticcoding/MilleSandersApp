import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:growthdeck/constants/k_colors.dart';
import 'package:growthdeck/services/http_service.dart';
import 'package:provider/provider.dart';

class ImpressumView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/wirstehenhinterdir.png'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(
                    'Dir haben die Decks geholfen und Spaß gemacht? Wir freuen uns sehr über eine Bewertung der App.',
                  ),
                  SizedBox(height: 20),
                  YellowButton(onTap: () {}, label: 'App bewerten'),
                  SizedBox(height: 30),
                  Text(
                    'Mit unserem montalichen Newsletter bekommst du ausgewählte Produktivitäts Tipps, Ideen und Motivierendes gesendet.\n5 Minuten Lesezeit - lohnt sich immer und ist gratis.',
                  ),
                  SizedBox(height: 20),
                  YellowButton(
                      onTap: () => HttpService.launchURL(
                          'https://millesanders.com/pages/newsletter'),
                      label: 'zum Newsletter anmelden'),
                  SizedBox(height: 20),
                  YellowButton(
                      onTap: () => HttpService.launchURL(
                          'https://millesanders.com/pages/impressum-growth-decks'),
                      label: 'Impressum|Datenschutz'),
                  SizedBox(height: 30),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Design von Alexander Kaufmann'),
                        Text('Code von Marco Papula'),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class YellowButton extends StatelessWidget {
  YellowButton({this.onTap, this.label});
  final Function onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: kColors.orange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:growthdeck/constants/mille_sanders_icons.dart';
import 'package:growthdeck/views_and_viewmodels/introduction_viewmodel.dart';

class IntroductionView extends StatelessWidget {
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
              image: AssetImage('assets/images/duhastdenwillen.png'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                'Danke, dass du Teil unserer Community bist!\n\n'),
                        TextSpan(
                            text:
                                'Mille Sanders dreht sich rund um die Themen '),
                        TextSpan(
                          text: 'Organisation, Produktivität und Planung.\n\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: 'Es geht um '),
                        TextSpan(
                          text: 'deine Ziele und Träume.',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                'Wir wollen dich motivieren diese zu erreichen und '),
                        TextSpan(
                          text:
                              'dir hilfreiche Tools dafür zur Verfügung stellen.\n\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: 'In unserem Sitz '),
                        TextSpan(
                          text: 'in Tirol ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                'designen wir einige unserer Produkte und verwalten von dort aus auch unseren Shop.'),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        BulletPoint(
                          icon: MilleSanders.noun_choose,
                          text: 'handverlesenes Sortiment',
                        ),
                        SizedBox(height: 10),
                        BulletPoint(
                          icon: MilleSanders.noun_talk,
                          text: 'persöhnliche Beratung',
                        ),
                        SizedBox(height: 10),
                        BulletPoint(
                          icon: MilleSanders.noun_shipping,
                          text: 'Versand nach DE und AT',
                        ),
                        SizedBox(height: 10),
                        BulletPoint(
                          icon: MilleSanders.noun_environment,
                          text: 'klein & nachhaltig',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Kontakt'),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            MilleSanders.iconfinder_facebook_messenger,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: IntroductionViewModel.launchEmail,
                          child: Icon(
                            MilleSanders.iconfinder_mail,
                            color: Colors.black,
                          ),
                        ),
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

class BulletPoint extends StatelessWidget {
  BulletPoint({this.icon, this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.black,
            size: 30,
          ),
          SizedBox(width: 15),
          Text(text),
        ],
      );
}
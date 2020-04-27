import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class AppRatingService {
  RateMyApp _rateMyApp;

  static Future<AppRatingService> create() async {
    var appRatingService = AppRatingService._create();
    appRatingService._rateMyApp = RateMyApp(
      preferencesPrefix: 'rateMyApp_',
      minDays: 3,
      minLaunches: 5,
      remindDays: 5,
      remindLaunches: 7,
      appStoreIdentifier: '',
      googlePlayIdentifier: '',
    );
    return appRatingService;
  }

  void promptAppRating(BuildContext context) async {
    _rateMyApp.init().then(
          (_) {
        if (_rateMyApp.shouldOpenDialog) {
          launchAppRating(context);
        }
      },
    );
  }

  void launchAppRating(BuildContext context) {
    _rateMyApp.showStarRateDialog(
      context,
      title: 'Enjoying our Growth Decks?',
      message: 'It would mean a lot to us, if you leave a rating.',
      actionsBuilder: (_, stars) => <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () async {
            await _rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
            Navigator.pop<RateMyAppDialogButton>(
                context, RateMyAppDialogButton.rate);
          },
        ),
      ],
    );
  }

  AppRatingService._create();
}

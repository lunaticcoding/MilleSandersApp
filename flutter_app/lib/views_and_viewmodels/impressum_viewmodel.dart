import 'package:growthdeck/services/http_service.dart';

class ImpressumViewModel {
  static void launchNewsletter() =>
      HttpService.launchURL('https://millesanders.com/pages/newsletter');
  static void launchImpressum() => HttpService.launchURL(
      'https://millesanders.com/pages/impressum-growth-decks');
}

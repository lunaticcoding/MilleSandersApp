import 'package:growthdeck/features/card_deck/domain/entities/section.dart';
import 'package:growthdeck/features/card_deck/domain/repositories/card_data_repository.dart';

class GetSections {
  final CardDataRepository repository;
  GetSections(this.repository);

  Stream<List<Section>> call() => repository.getSections();
}

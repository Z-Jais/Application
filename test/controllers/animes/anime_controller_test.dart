import 'package:flutter_test/flutter_test.dart';
import 'package:jais/controllers/animes/anime_controller.dart';
import 'package:jais/controllers/simulcast_controller.dart';
import 'package:jais/widgets/simulcasts/simulcast_widget.dart';

void main() {
  group('AnimeController', () {
    test('Init', () async {
      final controller = AnimeController();
      await Future.delayed(const Duration(seconds: 1));

      expect(controller.list, isNotEmpty);
      expect(controller.list, contains(controller.loadingWidget));
      expect(controller.lastPageError, isFalse);
      expect(controller.nothingToShow(), isFalse);
    });
    
    test('Load', () async {
      final SimulcastController simulcastController = SimulcastController();
      await simulcastController.load();
      await Future.delayed(const Duration(seconds: 1));

      final controller = AnimeController();
      controller.simulcast = (simulcastController.list.last as SimulcastWidget).simulcast;
      await controller.load();
      await Future.delayed(const Duration(seconds: 1));

      expect(controller.list, isNotEmpty);
      expect(controller.list, isNot(contains(controller.loadingWidget)));
      expect(controller.lastPageError, isFalse);
      expect(controller.nothingToShow(), isFalse);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:jais/controllers/episodes/episode_controller.dart';

void main() {
  group('EpisodeController', () {
    test('Init', () async {
      final controller = EpisodeController();
      await Future.delayed(const Duration(seconds: 1));

      expect(controller.list, isNotEmpty);
      expect(controller.list, contains(controller.loadingWidget));
      expect(controller.lastPageError, isFalse);
      expect(controller.nothingToShow(), isFalse);
    });
    
    test('Load', () async {
      final controller = EpisodeController();
      await controller.load();
      await Future.delayed(const Duration(seconds: 1));

      expect(controller.list, isNotEmpty);
      expect(controller.list, isNot(contains(controller.loadingWidget)));
      expect(controller.lastPageError, isFalse);
      expect(controller.nothingToShow(), isFalse);
    });
  });
}

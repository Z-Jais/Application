import 'package:flutter_test/flutter_test.dart';
import 'package:jais/controllers/simulcast_controller.dart';

void main() {
  group('SimulcastController', () {
    test('Init', () async {
      final controller = SimulcastController();
      await Future.delayed(const Duration(seconds: 1));

      expect(controller.list, isNotEmpty);
      expect(controller.list, contains(controller.loadingWidget));
      expect(controller.lastPageError, isFalse);
      expect(controller.nothingToShow(), isFalse);
    });

    test('Load', () async {
      final controller = SimulcastController();
      await controller.load();
      await Future.delayed(const Duration(seconds: 1));

      expect(controller.list, isNotEmpty);
      expect(controller.list, isNot(contains(controller.loadingWidget)));
      expect(controller.lastPageError, isFalse);
      expect(controller.nothingToShow(), isFalse);
    });
  });
}

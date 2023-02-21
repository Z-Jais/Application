import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jais/views/home_view.dart';
import 'package:jais/widgets/episodes/episode_list.dart';
import 'package:jais/widgets/top_navigation_bar.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('HomeView', () {
    testWidgets('Launch Android', (widgetTester) async {
      widgetTester.binding.window.physicalSizeTestValue = const Size(360, 640);
      widgetTester.binding.window.devicePixelRatioTestValue = 1.0;
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      await widgetTester.pumpWidget(const MaterialApp(home: HomeView()));
      debugDefaultTargetPlatformOverride = null;

      expect(find.byType(TopNavigationBar), findsOneWidget);
      expect(find.byType(VerticalDivider), findsNothing);
      expect(find.byType(EpisodeList), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });
  });
}

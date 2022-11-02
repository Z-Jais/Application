import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jais/components/animes/anime_loader_widget.dart';
import 'package:jais/components/episodes/episode_loader_widget.dart';
import 'package:jais/components/mangas/manga_loader_widget.dart';
import 'package:jais/components/simulcasts/simulcast_loader_widget.dart';
import 'package:jais/views/home_view.dart';

Future<void> _testApp(
  WidgetTester widgetTester,
  Size size, {
  required int episodes,
  required int mangas,
}) async {
  widgetTester.binding.window.devicePixelRatioTestValue = 1.0;
  widgetTester.binding.window.physicalSizeTestValue = size;

  await widgetTester.pumpWidget(const MaterialApp(home: HomeView()));

  expect(find.text('Jaïs'), findsOneWidget);
  expect(find.byType(BottomNavigationBar), findsOneWidget);

  // Episodes
  expect(find.byType(EpisodeLoaderWidget), findsNWidgets(episodes));

  // Mangas
  await widgetTester.tap(find.text('Mangas'));
  await widgetTester.pump();

  expect(find.byType(MangaLoaderWidget), findsNWidgets(mangas));

  // Animes
  await widgetTester.tap(find.text('Animes'));
  await widgetTester.pump();

  expect(find.byType(SimulcastLoaderWidget), findsNothing);
  expect(find.byType(AnimeLoaderWidget), findsNothing);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Test application', () {
    testWidgets('On 360x640', (WidgetTester widgetTester) async {
      _testApp(widgetTester, const Size(360, 640), episodes: 2, mangas: 5);
    });

    testWidgets('On 480x853', (WidgetTester widgetTester) async {
      _testApp(widgetTester, const Size(480, 853), episodes: 2, mangas: 6);
    });

    testWidgets('On 600x900', (WidgetTester widgetTester) async {
      _testApp(widgetTester, const Size(600, 900), episodes: 12, mangas: 18);
    });

    testWidgets('On 1280x850', (WidgetTester widgetTester) async {
      _testApp(widgetTester, const Size(1280, 850), episodes: 6, mangas: 18);
    });
  });
}

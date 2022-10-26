import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jais/components/animes/anime_loader_widget.dart';
import 'package:jais/components/episodes/episode_loader_widget.dart';
import 'package:jais/components/mangas/manga_loader_widget.dart';
import 'package:jais/components/simulcasts/simulcast_loader_widget.dart';
import 'package:jais/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Test application', () {
    testWidgets('On 360x640', (WidgetTester widgetTester) async {
      widgetTester.binding.window.devicePixelRatioTestValue = 1.0;
      widgetTester.binding.window.physicalSizeTestValue = const Size(360, 640);

      await widgetTester.pumpWidget(const MyApp());

      expect(find.text('Jaïs'), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      // Test episodes view
      expect(find.byType(EpisodeLoaderWidget), findsNWidgets(2));

      await widgetTester.tap(find.text('Mangas'));
      await widgetTester.pump();
      // Test mangas view
      expect(find.byType(MangaLoaderWidget), findsNWidgets(5));

      await widgetTester.tap(find.text('Animes'));
      await widgetTester.pump();
      // Test animes view
      expect(find.byType(SimulcastLoaderWidget), findsNothing);
      expect(find.byType(AnimeLoaderWidget), findsNothing);
    });

    testWidgets('On 480x853', (WidgetTester widgetTester) async {
      widgetTester.binding.window.devicePixelRatioTestValue = 1.0;
      widgetTester.binding.window.physicalSizeTestValue = const Size(480, 853);

      await widgetTester.pumpWidget(const MyApp());

      expect(find.text('Jaïs'), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      // Test episodes view
      expect(find.byType(EpisodeLoaderWidget), findsNWidgets(2));

      await widgetTester.tap(find.text('Mangas'));
      await widgetTester.pump();
      // Test mangas view
      expect(find.byType(MangaLoaderWidget), findsNWidgets(6));

      await widgetTester.tap(find.text('Animes'));
      await widgetTester.pump();
      // Test animes view
      expect(find.byType(SimulcastLoaderWidget), findsNothing);
      expect(find.byType(AnimeLoaderWidget), findsNothing);
    });

    testWidgets('On 600x900', (WidgetTester widgetTester) async {
      widgetTester.binding.window.devicePixelRatioTestValue = 1.0;
      widgetTester.binding.window.physicalSizeTestValue = const Size(600, 900);

      await widgetTester.pumpWidget(const MyApp());

      expect(find.text('Jaïs'), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      // Test episodes view
      expect(find.byType(EpisodeLoaderWidget), findsNWidgets(12));

      await widgetTester.tap(find.text('Mangas'));
      await widgetTester.pump();
      // Test mangas view
      expect(find.byType(MangaLoaderWidget), findsNWidgets(18));

      await widgetTester.tap(find.text('Animes'));
      await widgetTester.pump();
      // Test animes view
      expect(find.byType(SimulcastLoaderWidget), findsNothing);
      expect(find.byType(AnimeLoaderWidget), findsNothing);
    });

    testWidgets('On 1280x850', (WidgetTester widgetTester) async {
      widgetTester.binding.window.devicePixelRatioTestValue = 1.0;
      widgetTester.binding.window.physicalSizeTestValue = const Size(1280, 850);

      await widgetTester.pumpWidget(const MyApp());

      expect(find.text('Jaïs'), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      // Test episodes view
      expect(find.byType(EpisodeLoaderWidget), findsNWidgets(6));

      await widgetTester.tap(find.text('Mangas'));
      await widgetTester.pump();
      // Test mangas view
      expect(find.byType(MangaLoaderWidget), findsNWidgets(18));

      await widgetTester.tap(find.text('Animes'));
      await widgetTester.pump();
      // Test animes view
      expect(find.byType(SimulcastLoaderWidget), findsNothing);
      expect(find.byType(AnimeLoaderWidget), findsNothing);
    });
  });
}

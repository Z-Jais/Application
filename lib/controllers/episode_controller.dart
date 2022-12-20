import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/widgets/episodes/episode_loader_widget.dart';
import 'package:jais/widgets/episodes/episode_widget.dart';

class EpisodeController with ChangeNotifier {
  final int limit;
  final ScrollController _scrollController = ScrollController();
  final List<Widget> _list = [];
  bool _isLoading = false;
  int _page = 1;

  EpisodeController({required this.limit});

  ScrollController get scrollController => _scrollController;
  List<Widget> get list => _list;
  bool get isLoading => _isLoading;

  List<EpisodeLoaderWidget> get _loaders => List<EpisodeLoaderWidget>.generate(
        12,
        (_) => const EpisodeLoaderWidget(),
      );

  void _removeLoader() {
    _list.removeWhere((element) => element is EpisodeLoaderWidget);
  }

  void reset() {
    _list.clear();
    _isLoading = false;
    _page = 1;
  }

  Future<void> load() async {
    if (_isLoading) {
      return;
    }

    _isLoading = true;
    _list.addAll(_loaders);
    notifyListeners();

    try {
      final List<EpisodeWidget> widgets = await URLController()
          .get(
            'https://beta-api.ziedelth.fr/episodes/country/fr/page/$_page/limit/$limit',
          )
          .mapWithObjectIfOk(
            (p0) => EpisodeWidget(episode: Episode.fromJson(p0)),
          );

      _removeLoader();
      _list.addAll(widgets);
    } catch (exception, stackTrace) {
      log(
        'Error while loading episodes',
        error: exception,
        stackTrace: stackTrace,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

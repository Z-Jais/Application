import 'dart:developer';

import 'package:flutter/material.dart';

abstract class DataController<Model, ModelLoadingWidget extends Widget,
    ModelWidget extends Widget> with ChangeNotifier {
  final int limit;
  final ScrollController scrollController = ScrollController();
  final List<Widget> list = [];

  final ModelLoadingWidget loadingWidget;
  final Model Function(Map<String, dynamic>) fromJson;
  final ModelWidget Function(Model) toWidget;

  bool _isLoading = false;
  int page = 1;
  bool _canLoadMore = true;
  bool lastPageError = false;

  DataController({
    bool firstLoad = true,
    bool listener = true,
    bool addDefaultLoader = true,
    required this.limit,
    required this.loadingWidget,
    required this.fromJson,
    required this.toWidget,
  }) {
    if (addDefaultLoader) {
      list.addAll(_loaders);
    }

    if (firstLoad) {
      load();
    }

    if (listener) {
      scrollController.addListener(_onInfiniteScroll);
    }
  }

  void notify() {
    notifyListeners();
  }

  Future<void> _onInfiniteScroll() async {
    if (scrollController.position.extentAfter <= 0 &&
        !_isLoading &&
        _canLoadMore) {
      page++;
      await load();
    }
  }

  bool nothingToShow() =>
      (list.whereType<ModelWidget>().isEmpty && page == 1 && lastPageError) ||
      (!_isLoading && list.whereType<ModelWidget>().isEmpty && !_canLoadMore);

  List<ModelLoadingWidget> get _loaders =>
      List<ModelLoadingWidget>.generate(limit, (_) => loadingWidget);

  void _removeLoader() {
    list.removeWhere((element) => element is ModelLoadingWidget);
  }

  void reset() {
    list.clear();
    _isLoading = false;
    page = 1;
  }

  Future<List<ModelWidget>> widgets();

  Future<void> load() async {
    if (_isLoading) {
      print('Already loading $runtimeType');
      return;
    }

    print('Loading $runtimeType');
    _isLoading = true;
    list.addAll(_loaders);
    notifyListeners();

    try {
      print('Loading $runtimeType (page $page) ...');
      final List<ModelWidget> widgets = await this.widgets();
      _removeLoader();
      list.addAll(widgets);
      _canLoadMore = widgets.length == limit;
      lastPageError = false;
      print('Loading $runtimeType (page $page) done');
    } catch (exception, stackTrace) {
      lastPageError = true;

      log(
        'Error while loading $runtimeType',
        error: exception,
        stackTrace: stackTrace,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

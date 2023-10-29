import 'package:flutter/material.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/utils.dart';

abstract class DataController<Model, ModelLoadingWidget extends Widget,
    ModelWidget extends Widget> with ChangeNotifier {
  final int limit;
  final List<Widget> list = [];

  double _scrollbarPositionOnDetached = 0.0;
  late ScrollController scrollController = ScrollController(
    onDetach: (position) {
      _scrollbarPositionOnDetached = position.pixels;
    },
    onAttach: (position) {
      if (position.pixels == 0.0 && _scrollbarPositionOnDetached != 0.0) {
        if (scrollController.hasClients) {
          scrollController.scrollTo(
            _scrollbarPositionOnDetached,
            duration: const Duration(milliseconds: 25),
          );
        }
      }
    },
  );

  final ModelLoadingWidget loadingWidget;
  final Model Function(Map<String, dynamic>) fromJson;
  final ModelWidget Function(Model) toWidget;
  final VoidCallback notifyListenersCallback;

  bool _isLoading = false;
  int page = 1;
  bool _canLoadMore = true;
  bool lastPageError = false;

  DataController({
    bool listener = true,
    bool addDefaultLoader = true,
    required this.limit,
    required this.loadingWidget,
    required this.fromJson,
    required this.toWidget,
    required this.notifyListenersCallback,
  }) {
    if (addDefaultLoader) {
      list.addAll(_loaders);
    }

    if (listener) {
      scrollController.addListener(_onInfiniteScroll);
    }
  }

  void notify() {
    notifyListenersCallback();
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
      list.whereType<ModelWidget>().isEmpty &&
      (page == 1 && lastPageError || !_isLoading && !_canLoadMore);

  List<ModelLoadingWidget> get _loaders =>
      List<ModelLoadingWidget>.generate(limit, (_) => loadingWidget);

  void _removeLoader() {
    list.removeWhere((element) => element is ModelLoadingWidget);
  }

  void reset({bool loader = false}) {
    list.clear();
    _isLoading = false;
    page = 1;

    if (loader) {
      list.addAll(_loaders);
      notify();
    }
  }

  Future<List<ModelWidget>> widgets();

  Future<void> load() async {
    if (isLoading()) {
      return;
    }

    preLoad();

    try {
      final widgets = await loadWidgets();
      postLoad(widgets);
    } catch (exception, stackTrace) {
      handleError(exception, stackTrace);
    } finally {
      finalizeLoad();
    }
  }

  bool isLoading() {
    if (_isLoading) {
      warning(runtimeType.toString(), 'Already loading $runtimeType');
      return true;
    }
    return false;
  }

  void preLoad() {
    _isLoading = true;
    list.addAll(_loaders);
    notify();
    info(runtimeType.toString(), 'Loading (page $page) ...');
  }

  Future<List<ModelWidget>> loadWidgets() => this.widgets();

  void postLoad(List<ModelWidget> widgets) {
    _removeLoader();
    list.addAll(widgets);
    _canLoadMore = widgets.length == limit;
    lastPageError = false;
    info(runtimeType.toString(), 'Loading (page $page) done');
  }

  void handleError(dynamic exception, StackTrace stackTrace) {
    lastPageError = true;
    error(
      runtimeType.toString(),
      'Error while loading',
      exception,
      stackTrace,
    );
  }

  void finalizeLoad() {
    _isLoading = false;
    notify();
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jais/url/url.dart';
import 'package:jais/utils/utils.dart';

abstract class IMapper<T> extends ChangeNotifier {
  final int limit;
  final Widget loaderWidget;
  final List<Widget> list = <Widget>[];
  final ScrollController scrollController = ScrollController();
  final T Function(Map<String, dynamic>) fromJson;
  final Widget Function(T) toWidget;
  int page = 1;
  bool isLoading = false;
  bool canLoadMore = true;
  bool lastPageError = false;

  IMapper({
    required this.limit,
    required this.loaderWidget,
    required this.fromJson,
    required this.toWidget,
    bool listener = true,
  }) {
    if (listener) {
      scrollController.addListener(onInfiniteScroll);
    }
  }

  bool nothingToShow<R>() =>
      list.whereType<R>().isEmpty && page == 1 && lastPageError;

  bool canInfiniteScroll() {
    return scrollController.position.extentAfter <= 0 &&
        !isLoading &&
        canLoadMore;
  }

  Future<void> onInfiniteScroll() async {
    if (canInfiniteScroll()) {
      isLoading = true;
      Utils.instance.clearImagesCache();
      page++;
      final bool correct = await updateCurrentPage();

      if (!correct) {
        page--;
        canLoadMore = true;
        removeLoader();

        Future<void>.delayed(const Duration(seconds: 1)).then((_) {
          isLoading = false;
        });

        return;
      }

      isLoading = false;
      canLoadMore = list.length % limit == 0;
    }
  }

  List<Widget> get defaultList => List<Widget>.filled(
        limit,
        loaderWidget,
        growable: true,
      );

  void addLoader() {
    list.addAll(defaultList);
    notifyListeners();
  }

  void clear() {
    page = 1;
    list.clear();
    isLoading = false;
    canLoadMore = true;
    addLoader();
  }

  void removeLoader() {
    list.removeWhere(
      (Widget element) => element.runtimeType == loaderWidget.runtimeType,
    );

    notifyListeners();
  }

  List<Widget> toWidgets(String string) {
    try {
      return (jsonDecode(string) as List<dynamic>)
          .map<Widget>(
            (dynamic e) => toWidget(fromJson(e as Map<String, dynamic>)),
          )
          .toList();
    } catch (_) {
      return <Widget>[];
    }
  }

  Future<bool> loadPageWithFunction(
    Future<Response?> Function() function,
  ) async {
    isLoading = true;
    addLoader();
    final Response? response = await function();

    if (!response.isOk) {
      isLoading = false;
      canLoadMore = true;
      lastPageError = true;
      return false;
    }

    final List<Widget> widgets = toWidgets(utf8.decode(response!.bodyBytes));

    if (widgets.isEmpty) {
      lastPageError = true;
      isLoading = false;
      canLoadMore = false;
      notifyListeners();
      return false;
    }

    list.addAll(widgets);
    removeLoader();
    canLoadMore = list.length % limit == 0;
    isLoading = false;
    lastPageError = false;
    return true;
  }

  Future<void> reset() async {
    clear();
    await updateCurrentPage();
  }

  Future<bool> loadPageWithUrl(String url) async =>
      loadPageWithFunction(() => URL().get(url));

  Future<bool> updateCurrentPage();
}

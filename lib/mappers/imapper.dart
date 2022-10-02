import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jais/logger/logger.dart';
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

  IMapper({
    required this.limit,
    required this.loaderWidget,
    required this.fromJson,
    required this.toWidget,
    bool listener = true,
  }) {
    if (listener) {
      scrollController.addListener(() async {
        if (scrollController.position.extentAfter <= 0 &&
            !isLoading &&
            canLoadMore) {
          isLoading = true;
          Logger.info('Clearing images cache...');
          Utils.clearImagesCache();
          page++;
          Logger.debug('Loading page $page...');
          await updateCurrentPage();
          isLoading = false;
          canLoadMore = list.length % limit == 0;
          Logger.debug('Can load more: $canLoadMore');
        }
      });
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
              (dynamic e) => toWidget(fromJson(e as Map<String, dynamic>)))
          .toList();
    } catch (exception, stackTrace) {
      Logger.error('Error while parsing JSON', exception, stackTrace);
      return <Widget>[];
    }
  }

  Future<void> loadPage(String url) async {
    addLoader();
    final Response? response = await URL().get(url);

    if (!response.isOk) {
      return;
    }

    list.addAll(toWidgets(utf8.decode(response!.bodyBytes)));
    removeLoader();
  }

  Future<void> updateCurrentPage();
}

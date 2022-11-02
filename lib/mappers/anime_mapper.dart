import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jais/components/animes/anime_loader_widget.dart';
import 'package:jais/components/animes/anime_widget.dart';
import 'package:jais/entities/anime.dart';
import 'package:jais/entities/simulcast.dart';
import 'package:jais/mappers/device_mapper.dart';
import 'package:jais/mappers/imapper.dart';
import 'package:jais/url/url.dart';
import 'package:jais/url/url_const.dart';

class AnimeMapper extends IMapper<Anime> {
  Simulcast? simulcast;

  AnimeMapper({bool listener = true})
      : super(
          limit: 24,
          loaderWidget: const AnimeLoaderWidget(),
          fromJson: Anime.fromJson,
          toWidget: (Anime anime) => AnimeWidget(anime: anime),
          listener: listener,
        );

  @override
  Future<bool> updateCurrentPage() async {
    if (simulcast == null) {
      return false;
    }

    return await loadPage(UrlConst.getAnimesPage(simulcast!, page, limit));
  }

  Future<bool> search(String query) async {
    return await loadPage(UrlConst.getAnimesSearch(query));
  }

  Future<bool> updateWatchlistPage() async {
    isLoading = true;
    addLoader();
    final Response? response = await URL().post(
      UrlConst.getAnimesWatchlistPage(page, limit),
      body: await DeviceMapper.watchlistMapper.toGzip(),
    );

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

  Future<bool> getDiary(int day) async {
    return await loadPage(UrlConst.getDiary(day));
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_search_controller.dart';
import 'package:provider/provider.dart';

class AnimeSearchView extends StatefulWidget {
  final AnimeSearchController controller;

  const AnimeSearchView({required this.controller, super.key});

  @override
  State<StatefulWidget> createState() => _AnimeSearchViewState();
}

class _AnimeSearchViewState extends State<AnimeSearchView> {
  Timer? _timer;

  void _search() {
    _timer?.cancel();
    widget.controller.reset(loader: true);

    _timer = Timer(
      const Duration(milliseconds: 500),
      () async {
        if (widget.controller.query!.isNotEmpty) {
          await widget.controller.load();
        } else {
          widget.controller.notify();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Rechercher un anime'),
          onChanged: (String value) {
            widget.controller.query = value;
            _search();
          },
          onSubmitted: (String value) {
            widget.controller.query = value;
            _search();
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ChangeNotifierProvider.value(
                value: widget.controller,
                child: Consumer<AnimeSearchController>(
                  builder: (_, value, ___) {
                    return ListView.builder(
                      itemCount: value.list.length,
                      itemBuilder: (context, index) => value.list[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

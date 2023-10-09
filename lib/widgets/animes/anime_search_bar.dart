import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_search_controller.dart';

class AnimeSearchBar extends StatefulWidget {
  final AnimeSearchController controller;

  const AnimeSearchBar({required this.controller, super.key});

  @override
  State<AnimeSearchBar> createState() => _AnimeSearchBarState();
}

class _AnimeSearchBarState extends State<AnimeSearchBar> {
  final FocusNode _focusNode = FocusNode();
  Timer? _timer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });

    super.initState();
  }

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
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SearchBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        trailing: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              widget.controller.reset();
              await widget.controller.load();
            },
          ),
        ],
        hintText: 'Rechercher un anime',
        onChanged: (String value) {
          widget.controller.query = value;
          _search();
        },
        onSubmitted: (String value) {
          widget.controller.query = value;
          _search();
        },
        focusNode: _focusNode,
      ),
    );
  }
}

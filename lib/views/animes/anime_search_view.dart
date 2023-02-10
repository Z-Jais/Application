import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_search_controller.dart';
import 'package:jais/widgets/animes/anime_list.dart';

class AnimeSearchView extends StatelessWidget {
  final AnimeSearchController controller;

  const AnimeSearchView({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Rechercher un anime',
            border: InputBorder.none,
          ),
          autofocus: true,
          onSubmitted: (String value) async {
            controller.query = value;
            controller.reset();
            await controller.load();
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(child: AnimeList(controller: controller)),
          ],
        ),
      ),
    );
  }
}

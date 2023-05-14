import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_search_controller.dart';
import 'package:provider/provider.dart';

class AnimeSearchView extends StatelessWidget {
  final AnimeSearchController controller;

  const AnimeSearchView({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
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
                      controller.reset();
                      await controller.load();
                    },
                  ),
                ],
                hintText: 'Rechercher un anime',
                onChanged: (String value) {
                  controller.query = value;
                },
              ),
            ),
            Expanded(
              child: ChangeNotifierProvider.value(
                value: controller,
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

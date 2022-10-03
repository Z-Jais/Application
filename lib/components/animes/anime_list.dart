import 'package:flutter/material.dart';

class AnimeList extends StatelessWidget {
  final List<Widget> children;

  const AnimeList({required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: children);
  }
}

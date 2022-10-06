import 'package:flutter/material.dart';
import 'package:jais/components/skeleton.dart';
import 'package:jais/utils/const.dart';

class MangaLoaderWidget extends StatelessWidget {
  const MangaLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          const Skeleton(
            width: Const.animeImageWith,
            height: Const.animeImageHeight,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Skeleton(height: 20),
                SizedBox(height: 10),
                Skeleton(height: 70),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

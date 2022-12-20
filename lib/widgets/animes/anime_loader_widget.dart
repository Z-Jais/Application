import 'package:flutter/material.dart';
import 'package:jais/utils/const.dart';
import 'package:jais/widgets/decoration/border_decoration.dart';
import 'package:jais/widgets/skeleton.dart';

class AnimeLoaderWidget extends StatelessWidget {
  const AnimeLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BorderDecoration(
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

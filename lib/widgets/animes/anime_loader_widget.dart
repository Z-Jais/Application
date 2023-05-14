import 'package:flutter/material.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/decoration/border_decoration.dart';
import 'package:jais/widgets/skeleton.dart';

class AnimeLoaderWidget extends StatelessWidget {
  const AnimeLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const RepaintBoundary(
      child: BorderDecoration(
        child: Row(
          children: <Widget>[
            Skeleton(
              width: Const.animeImageWith,
              height: Const.animeImageHeight,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Skeleton(height: 20),
                  SizedBox(height: 10),
                  Skeleton(height: 70),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

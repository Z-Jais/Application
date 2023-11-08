import 'package:flutter/material.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/skeleton.dart';

class MissingAnimeLoaderWidget extends StatelessWidget {
  const MissingAnimeLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const RepaintBoundary(
      child: SizedBox.square(
        dimension: Const.missingAnimeImageWith + 30,
        child: Column(
          children: [
            Skeleton(
              width: Const.missingAnimeImageWith,
              height: Const.missingAnimeImageHeight,
              radius: 360,
            ),
            SizedBox(height: 7.5),
            Skeleton(height: 20),
          ],
        ),
      ),
    );
  }
}

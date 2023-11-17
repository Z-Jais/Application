import 'package:flutter/material.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/skeleton.dart';

class LiteEpisodeLoader extends StatelessWidget {
  const LiteEpisodeLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        decoration: Utils.instance.buildBoxDecoration(context),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 10),
        child: const Row(
          children: [
            Expanded(child: Skeleton(height: Const.episodeImageHeight / 2)),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton(width: 150, height: 20),
                  SizedBox(height: 5),
                  Skeleton(width: 100, height: 20),
                  SizedBox(height: 5),
                  Skeleton(width: 100, height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

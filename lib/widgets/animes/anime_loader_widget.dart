import 'package:flutter/material.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/skeleton.dart';

class AnimeLoaderWidget extends StatelessWidget {
  const AnimeLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        decoration: Utils.instance.buildBoxDecoration(context),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 10),
        child: const Row(
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

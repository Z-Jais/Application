import 'package:flutter/material.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/skeleton.dart';

class AnimeLoaderWidget extends StatelessWidget {
  const AnimeLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(4, 4),
            ),
          ],
        ),
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

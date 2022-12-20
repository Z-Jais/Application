import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfiniteScroll<T extends ChangeNotifier?> extends StatelessWidget {
  final T controller;
  final Widget Function() builder;

  const InfiniteScroll({
    required this.controller,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: controller,
      child: Consumer<T>(
        builder: (_, __, ___) => builder(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jais/controllers/data_controller.dart';
import 'package:jais/widgets/no_element.dart';
import 'package:provider/provider.dart';

class InfiniteScroll<T extends DataController> extends StatelessWidget {
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
        builder: (_, __, ___) =>
            controller.nothingToShow() ? const NoElement() : builder(),
      ),
    );
  }
}

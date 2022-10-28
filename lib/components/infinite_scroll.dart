import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfiniteScroll<T extends ChangeNotifier?> extends StatelessWidget {
  final T mapper;
  final Widget child;

  const InfiniteScroll({required this.mapper, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: mapper,
      child: Consumer<T>(
        builder: (_, __, ___) => child,
      ),
    );
  }
}

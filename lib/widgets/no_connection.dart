import 'dart:developer';

import 'package:flutter/material.dart';

class NoConnection extends StatelessWidget {
  final VoidCallback? onRetry;

  const NoConnection({this.onRetry, super.key});

  @override
  Widget build(BuildContext context) {
    log('NoConnection.build()');

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/no_connection.png', width: 200),
        const SizedBox(height: 10),
        Text(
          'Mince !',
          style: Theme.of(context).textTheme.headline6,
        ),
        const Text('Impossible de se connecter à Jaïs.'),
        const SizedBox(height: 10),
        TextButton(
          onPressed: onRetry,
          child: const Text('Réessayer'),
        ),
      ],
    );
  }
}

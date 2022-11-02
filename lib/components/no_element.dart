import 'package:flutter/material.dart';

class NoElement extends StatelessWidget {
  const NoElement({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset('assets/no_element.png', width: 200),
          const SizedBox(height: 10),
          Text(
            'Mince !',
            style: Theme.of(context).textTheme.headline6,
          ),
          const Text('Aucun élément à afficher'),
        ],
      ),
    );
  }
}

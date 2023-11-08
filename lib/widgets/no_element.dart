import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jais/controllers/logger.dart';

class NoElement extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onTap;
  final String? textButton;

  const NoElement({
    required this.title,
    required this.message,
    this.onTap,
    this.textButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    warning('NoElement', 'build()');

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Image(image: AssetImage('assets/no.png'), width: 200),
          const SizedBox(height: 30),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(message, textAlign: TextAlign.center),
          if (onTap != null) ...[
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onTap,
              child: Text(textButton ?? AppLocalizations.of(context)!.retry),
            ),
          ],
        ],
      ),
    );
  }
}

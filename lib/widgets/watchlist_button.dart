import 'package:flutter/material.dart';
import 'package:jais/controllers/notification_controller.dart';

class WatchlistButton extends StatefulWidget {
  final bool inWatchlist;
  final Function(bool) onToggle;

  const WatchlistButton({
    required this.onToggle,
    this.inWatchlist = false,
    super.key,
  });

  @override
  State<WatchlistButton> createState() => _WatchlistButtonState();
}

class _WatchlistButtonState extends State<WatchlistButton> {
  late bool _inWatchlist;

  @override
  void initState() {
    _inWatchlist = widget.inWatchlist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _inWatchlist
                ? Icons.indeterminate_check_box_outlined
                : Icons.add_box_outlined,
            color: _inWatchlist ? Colors.red : Colors.green,
          ),
          const SizedBox(width: 5),
          Text(
            _inWatchlist ? 'Retirer de ma watchlist' : 'Ajouter à ma watchlist',
          ),
        ],
      ),
      onPressed: () async {
        await widget.onToggle(_inWatchlist);

        if (await NotificationController.instance.isWatchlist) {
          NotificationController.instance.subscribeToWatchlist();
        }

        setState(() {
          _inWatchlist = !_inWatchlist;
        });
      },
    );
  }
}

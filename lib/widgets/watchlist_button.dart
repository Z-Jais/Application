import 'package:flutter/material.dart';

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
    return IconButton(
      icon: Icon(
        _inWatchlist
            ? Icons.indeterminate_check_box_outlined
            : Icons.add_box_outlined,
        color: _inWatchlist ? Colors.red : Colors.green,
      ),
      onPressed: () async {
        await widget.onToggle(_inWatchlist);

        setState(() {
          _inWatchlist = !_inWatchlist;
        });
      },
    );
  }
}

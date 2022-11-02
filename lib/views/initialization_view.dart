import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:jais/components/no_connection.dart';
import 'package:jais/mappers/device_mapper.dart';
import 'package:jais/views/home_view.dart';

class InitializationView extends StatefulWidget {
  const InitializationView({super.key});

  @override
  State<InitializationView> createState() => _InitializationViewState();
}

class _InitializationViewState extends State<InitializationView> {
  Future<bool> _hasInternet = DeviceMapper.hasInternet();

  Future<void> _needsReview() async {
    final bool showRequestReview =
        await DeviceMapper.reviewMapper.canShowReview();

    if (!mounted || !showRequestReview) {
      return;
    }

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Aimez-vous notre application ?'),
          content: const Text('Voulez-vous laisser un avis ?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Non'),
              onPressed: () async {
                Navigator.pop(context);
                await DeviceMapper.reviewMapper.neverReview();
              },
            ),
            TextButton(
              child: const Text('Plus tard'),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Oui'),
              onPressed: () async {
                Navigator.pop(context);
                await DeviceMapper.reviewMapper.acceptReview();
                InAppReview.instance.requestReview();
              },
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _needsReview();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _hasInternet,
      builder: (_, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (!snapshot.data!) {
          return Scaffold(
            body: NoConnection(
              onRetry: () async {
                _hasInternet = DeviceMapper.hasInternet();
                setState(() {});
              },
            ),
          );
        }

        return const HomeView();
      },
    );
  }
}

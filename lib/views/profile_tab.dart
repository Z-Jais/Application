import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/notification_controller.dart';
import 'package:jais/controllers/profile/profile_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/categories/category.dart';
import 'package:jais/widgets/categories/category_button.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  Future<bool> _checkIfSomethingIsRunning(
    NotificationController value,
    BuildContext context,
  ) async {
    if (!value.isRunning) {
      return false;
    }

    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Veuillez patienter un instant...',
          textAlign: TextAlign.center,
        ),
      ),
    );

    if (await Vibration.hasVibrator() == true) {
      Vibration.vibrate(duration: 100);
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (AppController.seen.data.isNotEmpty)
              FutureBuilder(
                future: ProfileController.instance.getTotalDuration(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Category(
                      label: 'STATISTIQUES AVANCÉES',
                      buttons: [
                        CategoryButton(
                          label:
                              'Série(s) : ${AppController.watchlist.data.length}',
                          icon: const Icon(Icons.video_library),
                        ),
                        CategoryButton(
                          label:
                              'Épisode(s) vu(s) : ${AppController.seen.data.length}',
                          icon: const Icon(Icons.subscriptions),
                        ),
                        CategoryButton(
                          label:
                              'Durée totale : ${Utils.instance.printDurationWithLetters(Duration(seconds: snapshot.data!))}',
                          icon: const Icon(Icons.watch_later),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ChangeNotifierProvider.value(
              value: NotificationController.instance,
              child: Consumer<NotificationController>(
                builder: (_, value, __) {
                  return Category(
                    label: 'NOTIFICATION',
                    trailing: value.isRunning
                        ? const Wrap(
                            children: [
                              Text('Chargement...'),
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: SizedBox(
                                  width: 16,
                                  height: 16,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                ),
                              ),
                            ],
                          )
                        : null,
                    buttons: [
                      FutureBuilder(
                        future: value.isAll,
                        builder: (context, snapshot) {
                          final isEnabled = snapshot.data == true;

                          return CategoryButton(
                            label: 'Toutes',
                            icon: Icon(
                              isEnabled
                                  ? Icons.notifications_active
                                  : Icons.notifications_off_outlined,
                            ),
                            trailing:
                                isEnabled ? const Icon(Icons.check) : null,
                            onTap: () async {
                              if (!await _checkIfSomethingIsRunning(
                                value,
                                context,
                              )) {
                                await value
                                    .setNotificationType(NotificationType.all);
                              }
                            },
                          );
                        },
                      ),
                      FutureBuilder(
                        future: value.isWatchlist,
                        builder: (context, snapshot) {
                          final isEnabled = snapshot.data == true;

                          return CategoryButton(
                            label: 'Watchlist',
                            icon: Icon(
                              isEnabled
                                  ? Icons.edit_notifications
                                  : Icons.edit_notifications_outlined,
                            ),
                            trailing:
                                isEnabled ? const Icon(Icons.check) : null,
                            onTap: () async {
                              if (!await _checkIfSomethingIsRunning(
                                value,
                                context,
                              )) {
                                await value.setNotificationType(
                                  NotificationType.watchlist,
                                );
                              }
                            },
                          );
                        },
                      ),
                      FutureBuilder(
                        future: value.isDisabled,
                        builder: (context, snapshot) {
                          final isEnabled = snapshot.data == true;

                          return CategoryButton(
                            label: 'Désactivé',
                            icon: Icon(
                              isEnabled
                                  ? Icons.notifications_off
                                  : Icons.notifications_off_outlined,
                            ),
                            trailing:
                                isEnabled ? const Icon(Icons.check) : null,
                            onTap: () async {
                              if (!await _checkIfSomethingIsRunning(
                                value,
                                context,
                              )) {
                                await value.setNotificationType(
                                  NotificationType.disabled,
                                );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            Category(
              label: 'ASSISTANCE',
              buttons: [
                CategoryButton(
                  label: 'Nous contacter',
                  icon: const Icon(Icons.email_outlined),
                  onTap: () {
                    URLController().mailTo('jais@ziedelth.fr');
                  },
                ),
                CategoryButton(
                  label: 'X (Twitter)',
                  icon: SvgPicture.asset(
                    'assets/x-twitter.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onSurface,
                      BlendMode.srcIn,
                    ),
                  ),
                  onTap: () {
                    URLController().goOnUrl('https://x.com/Jaiss___');
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            Category(
              label: 'AUTRE',
              buttons: [
                CategoryButton(
                  label: 'Suppression des données',
                  icon: const Icon(Icons.delete_forever_outlined),
                  onTap: () {
                    final appController =
                        Provider.of<AppController>(context, listen: false);

                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Suppression des données'),
                        content: const Text(
                          'Êtes-vous sûr de vouloir supprimer toutes vos données ?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Annuler'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              appController.reset();
                            },
                            child: const Text('Supprimer'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                CategoryButton(
                  label: 'Demande de fonctionnalité / Signaler un bug',
                  icon: const Icon(Icons.add_box_outlined),
                  onTap: () {
                    URLController().goOnUrl(
                      'https://github.com/Z-Jais/Application/issues/new',
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

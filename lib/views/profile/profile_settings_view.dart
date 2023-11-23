import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/notification_controller.dart';
import 'package:jais/controllers/profile_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/widgets/categories/category.dart';
import 'package:jais/widgets/categories/category_button.dart';
import 'package:jais/widgets/categories/category_filter_watchlist.dart';
import 'package:provider/provider.dart';

class ProfileSettingsView extends StatefulWidget {
  const ProfileSettingsView({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileSettingsViewState();
}

class _ProfileSettingsViewState extends State<ProfileSettingsView> {
  final TextEditingController textEditingController = TextEditingController();

  bool _checkIfSomethingIsRunning(
    NotificationController value,
    BuildContext context,
  ) {
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

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Paramètres'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ChangeNotifierProvider.value(
                        value: NotificationController.instance,
                        child: Consumer<NotificationController>(
                          builder: (context, value, child) {
                            return Category(
                              label: 'NOTIFICATIONS',
                              trailing: value.isRunning
                                  ? const Wrap(
                                      children: [
                                        Text('Chargement...'),
                                        Padding(
                                          padding: EdgeInsets.only(left: 8),
                                          child: SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: CircularProgressIndicator(
                                                strokeWidth: 2),
                                          ),
                                        ),
                                      ],
                                    )
                                  : null,
                              children: [
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
                                      trailing: isEnabled
                                          ? const Icon(Icons.check)
                                          : null,
                                      onTap: () async {
                                        if (!_checkIfSomethingIsRunning(
                                          value,
                                          context,
                                        )) {
                                          await value.setNotificationType(
                                              NotificationType.all);
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
                                      trailing: isEnabled
                                          ? const Icon(Icons.check)
                                          : null,
                                      onTap: () async {
                                        if (!_checkIfSomethingIsRunning(
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
                                      trailing: isEnabled
                                          ? const Icon(Icons.check)
                                          : null,
                                      onTap: () async {
                                        if (!_checkIfSomethingIsRunning(
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
                      const CategoryFilterWatchlist(),
                      const SizedBox(height: 32),
                      Category(
                        label: 'ASSISTANCE',
                        children: [
                          CategoryButton(
                            label: 'Nous contacter',
                            icon: const Icon(Icons.email_outlined),
                            onTap: () {
                              URLController.instance.mailTo('jais@ziedelth.fr');
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
                              URLController.instance
                                  .goOnUrl('https://x.com/Jaiss___');
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Category(
                        label: 'AUTRE',
                        children: [
                          CategoryButton(
                            label: 'Voir mon identifiant',
                            icon: const Icon(Icons.info_outline),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Identifiant'),
                                  content: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: SelectableText(
                                            ProfileController
                                                .instance.registeredDevice,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.copy),
                                        onPressed: () {
                                          Clipboard.setData(
                                            ClipboardData(
                                              text: ProfileController
                                                  .instance.registeredDevice,
                                            ),
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Identifiant copié',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          CategoryButton(
                            label: 'Changer mon identifiant',
                            icon: const Icon(Icons.edit_outlined),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                  title: const Text('Changer mon identifiant'),
                                  content: Column(
                                    children: [
                                      const Text(
                                        'Êtes-vous sûr de vouloir changer votre identifiant ?',
                                      ),
                                      const SizedBox(height: 16),
                                      TextField(
                                        controller: textEditingController,
                                        decoration: const InputDecoration(
                                          labelText: 'Nouvel identifiant',
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Annuler'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Changement de l\'identifiant...',
                                              textAlign: TextAlign.center,
                                            ),
                                            duration: Duration(seconds: 10),
                                          ),
                                        );

                                        await ProfileController.instance
                                            .setTokenUuid(
                                          textEditingController.text,
                                        );
                                        await ProfileController.instance.init();

                                        if (!context.mounted) return;
                                        ScaffoldMessenger.of(context)
                                            .removeCurrentSnackBar();

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Identifiant changé',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text('Changer'),
                                    ),
                                  ],
                                );
                                },
                              );
                            },
                          ),
                          CategoryButton(
                            label: 'Suppression des données',
                            icon: const Icon(Icons.delete_forever_outlined),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
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
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Suppression des données...',
                                              textAlign: TextAlign.center,
                                            ),
                                            duration: Duration(seconds: 10),
                                          ),
                                        );

                                        await ProfileController.instance
                                            .delete();

                                        if (!context.mounted) return;
                                        ScaffoldMessenger.of(context)
                                            .removeCurrentSnackBar();

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Données supprimées\nInitialisation des données par défaut...',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );

                                        await AppController.instance
                                            .initialize(context);
                                      },
                                      child: const Text('Supprimer'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          CategoryButton(
                            label:
                                'Demande de fonctionnalité / Signaler un bug',
                            icon: const Icon(Icons.add_box_outlined),
                            onTap: () {
                              URLController.instance.goOnUrl(
                                'https://github.com/Z-Jais/Application/issues/new',
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

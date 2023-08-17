import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/widgets/categories/category.dart';
import 'package:jais/widgets/categories/category_button.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
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
    );
  }
}

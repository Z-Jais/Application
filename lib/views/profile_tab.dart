import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/widgets/categories/category.dart';
import 'package:jais/widgets/categories/category_button.dart';

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
        ],
      ),
    );
  }
}

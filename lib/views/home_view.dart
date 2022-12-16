import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jais/components/navbar.dart';
import 'package:jais/mappers/device_mapper.dart';
import 'package:jais/mappers/navbar_mapper.dart';
import 'package:jais/views/animes/animes_view.dart';
import 'package:jais/views/animes/animes_watchlist_view.dart';
import 'package:jais/views/episodes/episodes_view.dart';
import 'package:jais/views/episodes/episodes_watchlist_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<void>(
          future: DeviceMapper.instance.createGlobalBanner(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SizedBox(
                height: 50,
                child: AdWidget(
                  ad: DeviceMapper.instance.globalBannerAd!,
                ),
              );
            }

            return const ColoredBox(color: Colors.transparent);
          },
        ),
        const Navbar(),
        Expanded(
          child: ChangeNotifierProvider<NavbarMapper>.value(
            value: NavbarMapper.instance,
            child: Consumer<NavbarMapper>(
              builder: (context, value, child) {
                return PageView(
                  controller: value.pageController,
                  onPageChanged: value.changePage,
                  children: <Widget>[
                    EpisodesView(),
                    if (value.isList)
                      AnimesWatchlistView()
                    else
                      EpisodesWatchlistView(),
                    const AnimesView(),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

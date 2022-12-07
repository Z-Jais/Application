import 'package:flutter/material.dart';
import 'package:jais/components/no_connection.dart';
import 'package:jais/mappers/initialization_mapper.dart';
import 'package:jais/mappers/navbar_mapper.dart';
import 'package:jais/views/home_view.dart';
import 'package:provider/provider.dart';

class InitializationView extends StatelessWidget {
  const InitializationView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: Center(
          child: ChangeNotifierProvider<InitializationMapper>.value(
            value: InitializationMapper(),
            child: Consumer<InitializationMapper>(
              builder: (context, value, child) {
                if (value.model.inProgress) {
                  return const CircularProgressIndicator();
                }

                if (!value.model.hasInternet) {
                  return NoConnection(
                    onRetry: () => value.initialize(),
                  );
                }

                return const HomeView();
              },
            ),
          ),
        ),
        bottomNavigationBar: ChangeNotifierProvider<NavbarMapper>.value(
          value: NavbarMapper.instance,
          child: Consumer<NavbarMapper>(
            builder: (context, value, child) {
              return BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: Colors.grey,
                currentIndex: value.currentPage,
                onTap: (page) => value.changePage(page, fromNavBar: true),
                items: [...value.itemsBottomNavBar(context)],
              );
            },
          ),
        ),
      ),
    );
  }
}

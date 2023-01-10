import 'dart:io';
import 'dart:ui';

import 'package:local_notifier/local_notifier.dart';
import 'package:system_tray/system_tray.dart';
import 'package:window_manager/window_manager.dart';

class WindowsPlatformController {
  static final WindowsPlatformController instance = WindowsPlatformController();

  Future<void> init() async {
    await windowManager.ensureInitialized();

    const WindowOptions windowOptions = WindowOptions(
      minimumSize: Size(800, 600),
      center: true,
      title: 'Jaïs',
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });

    final SystemTray systemTray = SystemTray();
    await systemTray.initSystemTray(
      iconPath: 'assets/icon.ico',
      title: 'Jaïs',
      toolTip: 'Jaïs',
    );

    final Menu menu = Menu();
    await menu.buildFrom([
      MenuItemLabel(
        label: 'Afficher',
        onClicked: (menuItem) => windowManager.show(),
      ),
      MenuItemLabel(
        label: 'Cacher',
        onClicked: (menuItem) => windowManager.hide(),
      ),
      MenuSeparator(),
      MenuItemLabel(
        label: 'Quitter',
        onClicked: (menuItem) => windowManager.close(),
      ),
    ]);

    await systemTray.setContextMenu(menu);

    systemTray.registerSystemTrayEventHandler((eventName) {
      if (eventName == kSystemTrayEventClick) {
        Platform.isWindows
            ? windowManager.show()
            : systemTray.popUpContextMenu();
      } else if (eventName == kSystemTrayEventRightClick) {
        Platform.isWindows
            ? systemTray.popUpContextMenu()
            : windowManager.show();
      }
    });

    await localNotifier.setup(appName: 'Jaïs');
    await LocalNotification(title: 'test', body: 'test').show();
  }
}

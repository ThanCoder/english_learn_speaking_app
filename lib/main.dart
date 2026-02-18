import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:than_pkg/than_pkg.dart';
import 'package:english_learn_speaking/app/my_app.dart';
import 'package:english_learn_speaking/more_libs/desktop_exe/desktop_exe.dart';
import 'package:english_learn_speaking/more_libs/setting/setting.dart';

void main() async {
  await ThanPkg.instance.init();

  await Setting.instance.init(
    appName: 'English Learn App',
    // releaseUrl: 'http',
    onSettingSaved: (context, message) {
      showTSnackBar(context, message);
    },
  );

  await TWidgets.instance.init(
    initialThemeServices: true,
    defaultImageAssetsPath: 'assets/thancoder_logo.png',
    isDarkTheme: () => Setting.getAppConfig.isDarkTheme,
  );

  if (TPlatform.isDesktop) {
    await DesktopExe.exportDesktopIcon(
      name: Setting.instance.appName,
      assetsIconPath: 'assets/thancoder_logo.png',
    );

    WindowOptions windowOptions = WindowOptions(
      size: Size(602, 568), // စတင်ဖွင့်တဲ့အချိန် window size

      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      center: false,
      title: Setting.instance.appName,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      // await windowManager.focus();
    });
  }
  runApp(const MyApp());
}

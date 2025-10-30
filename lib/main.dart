import 'package:english_learn_speaking/app/my_app.dart';
import 'package:english_learn_speaking/more_libs/setting_v2.9.0/setting.dart';
import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets_dev.dart';
import 'package:than_pkg/than_pkg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThanPkg.instance.init();

  await Setting.instance.initSetting(
    appName: 'Learn English Speaking',
    packageName: 'english_learn_speaking',
    releaseUrl:
        'https://github.com/ThanCoder/english_learn_speaking_app/releases',
  );

  await TWidgets.instance.init(defaultImageAssetsPath: 'assets/logo.webp');

  if (TPlatform.isDesktop) {
    WindowOptions windowOptions = const WindowOptions(
      size: Size(602, 568), // စတင်ဖွင့်တဲ့အချိန် window size

      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      center: false,
      title: "Novel V3",
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(const MyApp());
}

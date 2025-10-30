import 'package:english_learn_speaking/more_libs/setting_v2.9.0/setting.dart';
import 'package:flutter/material.dart';
import 'package:t_widgets/theme/t_theme_services.dart';
import 'package:than_pkg/than_pkg.dart';

class TThemeModesChooser extends StatefulWidget {
  const TThemeModesChooser({super.key});

  @override
  State<TThemeModesChooser> createState() => _TThemeModesChooserState();
}

class _TThemeModesChooserState extends State<TThemeModesChooser> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Theme',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            ValueListenableBuilder(
              valueListenable: Setting.getAppConfigNotifier,
              builder: (context, config, child) {
                return DropdownButton<TThemeModes>(
                  padding: EdgeInsets.all(5),
                  borderRadius: BorderRadius.circular(4),
                  value: config.themeMode,
                  items: TThemeModes.values
                      .map(
                        (e) => DropdownMenuItem<TThemeModes>(
                          value: e,
                          child: Text(e.name.toCaptalize()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    final newConfig = config.copyWith(
                      themeMode: value,
                      isDarkTheme: value!.isDarkMode,
                    );
                    Setting.getAppConfigNotifier.value = newConfig;
                    newConfig.save();
                    TThemeServices.instance.init();

                    if (!mounted) return;
                    setState(() {});
                  },
                );
              },
            ),
            SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}

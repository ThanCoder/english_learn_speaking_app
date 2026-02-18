import 'package:flutter/material.dart';
import 'package:english_learn_speaking/app/ui/home/home_screen.dart';
import 'package:english_learn_speaking/more_libs/setting/core/theme_listener.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeListener(
      builder: (context, themeMode) => MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: themeMode,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: HomeScreen(),
      ),
    );
  }
}

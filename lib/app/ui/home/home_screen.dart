import 'package:english_learn_speaking/more_libs/setting_v2.9.0/setting.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Setting.instance.appName)),
      body: Placeholder(),
    );
  }
}

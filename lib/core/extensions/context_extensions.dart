import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  void closeNavigator({bool? returnResult}) {
    Navigator.pop(this, returnResult);
  }

  void goRoute({required Widget Function(BuildContext context) builder}) {
    Navigator.push(this, MaterialPageRoute(builder: builder));
  }
}

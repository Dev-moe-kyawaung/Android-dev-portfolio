import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final bool safeArea;

  const AppScaffold({super.key, required this.child, this.appBar, this.bottomNavigationBar, this.safeArea = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar, bottomNavigationBar: bottomNavigationBar, body: safeArea ? SafeArea(child: child) : child);
  }
}

import 'package:flutter/material.dart';
import '../features/home/home_page.dart';
import '../data/sample_projects.dart';

class AndroidDevPortfolio extends StatelessWidget {
  const AndroidDevPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Android Developer Portfolio',
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      home: const PortfolioHomePage(projects: sampleProjects),
    );
  }
}

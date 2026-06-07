import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const AndroidDevPortfolio());

// ========== MODEL ==========
class Project {
  final String title;
  final String summary;
  final String role;
  final String category;
  final List<String> screenshots;
  final String githubUrl;
  final String playStoreUrl;
  final List<String> techStack;
  final List<Metric> metrics;

  const Project({
    required this.title,
    required this.summary,
    required this.role,
    required this.category,
    required this.screenshots,
    required this.githubUrl,
    required this.playStoreUrl,
    required this.techStack,
    required this.metrics,
  });
}

class Metric {
  final String label;
  final String value;

  const Metric({required this.label, required this.value});
}

// ========== SAMPLE DATA (Replace with your 5 real projects) ==========
const sampleProjects = <Project>[
  Project(
    title: 'Video Player',
    summary: 'Senior-level video player with advanced features and smooth playback.',
    role: 'Senior Android Developer',
    category: 'Media',
    screenshots: [
      'assets/screenshots/video_player_1.png',
      'assets/screenshots/video_player_2.png',
      'assets/screenshots/video_player_3.png',
    ],
    githubUrl: 'https://github.com/Moekyawaung/video-player',
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.moekyawaung.videoplayer',
    techStack: ['Kotlin', 'Jetpack Compose', 'MVVM', 'ExoPlayer', 'Coroutines'],
    metrics: [
      Metric(label: 'Load Time', value: '1.2s'),
      Metric(label: 'Crash Rate', value: '0.3%'),
      Metric(label: 'Downloads', value: '50K+'),
    ],
  ),
  Project(
    title: 'Data Visualization Dashboard',
    summary: 'Interactive R + ggplot2 visualizations with real-time filtering.',
    role: 'Lead Developer',
    category: 'Analytics',
    screenshots: [
      'assets/screenshots/dashboard_1.png',
      'assets/screenshots/dashboard_2.png',
    ],
    githubUrl: 'https://github.com/Moekyawaung/data-dashboard',
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.moekyawaung.dashboard',
    techStack: ['R', 'ggplot2', 'Shiny', 'Flutter', 'REST API'],
    metrics: [
      Metric(label: 'Query Time', value: '200ms'),
      Metric(label: 'Users', value: '10K+'),
      Metric(label: 'Accuracy', value: '99.5%'),
    ],
  ),
  Project(
    title: 'Android Portfolio App',
    summary: 'Modern Android app with clean architecture and responsive UI.',
    role: 'Senior Android Developer',
    category: 'Portfolio',
    screenshots: [
      'assets/screenshots/portfolio_1.png',
      'assets/screenshots/portfolio_2.png',
      'assets/screenshots/portfolio_3.png',
    ],
    githubUrl: 'https://github.com/Moekyawaung/portfolio',
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.moekyawaung.portfolio',
    techStack: ['Kotlin', 'Jetpack Compose', 'MVVM', 'Room', 'Dagger-Hilt'],
    metrics: [
      Metric(label: 'Performance', value: '+40%'),
      Metric(label: 'Tests', value: '85%'),
      Metric(label: 'Rating', value: '4.8⭐'),
    ],
  ),
  Project(
    title: 'E-Commerce App',
    summary: 'Full-stack shopping app with cart, payments, and order tracking.',
    role: 'Lead Android Developer',
    category: 'Commerce',
    screenshots: [
      'assets/screenshots/ecommerce_1.png',
      'assets/screenshots/ecommerce_2.png',
    ],
    githubUrl: 'https://github.com/Moekyawaung/ecommerce',
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.moekyawaung.ecommerce',
    techStack: ['Kotlin', 'Flow', 'MVVM', 'Firebase', 'Stripe'],
    metrics: [
      Metric(label: 'Conversion', value: '+35%'),
      Metric(label: 'Latency', value: '300ms'),
      Metric(label: 'Revenue', value: '$1M+'),
    ],
  ),
  Project(
    title: 'Health Tracker',
    summary: 'Fitness app with workout logging, stats, and wearable integration.',
    role: 'Senior Android Developer',
    category: 'Health',
    screenshots: [
      'assets/screenshots/health_1.png',
      'assets/screenshots/health_2.png',
      'assets/screenshots/health_3.png',
    ],
    githubUrl: 'https://github.com/Moekyawaung/health-tracker',
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.moekyawaung.health',
    techStack: ['Kotlin', 'WorkManager', 'MVVM', 'Google Fit', 'Room'],
    metrics: [
      Metric(label: 'Active Users', value: '25K+'),
      Metric(label: 'Retention', value: '68%'),
      Metric(label: 'Sync Time', value: '500ms'),
    ],
  ),
];

// ========== APP SCAFFOLD ==========
class AppScaffold extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final bool safeArea;

  const AppScaffold({
    super.key,
    required this.child,
    this.appBar,
    this.bottomNavigationBar,
    this.safeArea = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: safeArea ? SafeArea(child: child) : child,
    );
  }
}

// ========== RESPONSIVE LAYOUT ==========
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return mobile;
    if (width < 900) return tablet;
    return desktop;
  }
}

// ========== SECTION TITLE ==========
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

// ========== URL HELPER ==========
void openExternal(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}

// ========== HERO SECTION ==========
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Moe Kyaw Aung',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Senior Android Developer',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '5 years shipping production Android apps with Kotlin, Jetpack Compose, and MVVM',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PortfolioHomePage(projects: sampleProjects)),
                ),
                child: const Text('View Projects'),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                onPressed: () => openExternal('https://github.com/Moekyawaung/moekyawaung.github.io'),
                child: const Text('Download Resume'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ========== HOME PAGE ==========
class PortfolioHomePage extends StatelessWidget {
  final List<Project> projects;

  const PortfolioHomePage({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: ResponsiveLayout(
        mobile: _buildMobile(context),
        tablet: _buildTablet(context),
        desktop: _buildDesktop(context),
      ),
    );
  }

  Widget _buildMobile(BuildContext context) => _buildProjectGrid(context);
  Widget _buildTablet(BuildContext context) => _buildProjectGrid(context);
  Widget _buildDesktop(BuildContext context) => _buildProjectGrid(context);

  Widget _buildProjectGrid(BuildContext context) {
    return Column(
      children: [
        HeroSection(),
        SectionTitle(title: 'Featured Projects'),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return ProjectCard(project: projects[index], onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProjectDetailPage(project: projects[index])),
                );
              });
            },
          ),
        ),
      ],
    );
  }
}

// ========== PROJECT CARD ==========
class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;

  const ProjectCard({super.key, required this.project, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(project.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(project.summary, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: project.techStack.take(3).map((tag) => Chip(
                  label: Text(tag, style: const TextStyle(fontSize: 12)),
                )).toList(),
              ),
              const SizedBox(height: 12),
              Row(
                children: project.metrics.take(1).map((m) => Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(m.label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      Text(m.value, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ========== PROJECT DETAIL PAGE ==========
class ProjectDetailPage extends StatelessWidget {
  final Project project;

  const ProjectDetailPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text(project.title),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onTap: () => Navigator.pop(context)),
      ),
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Screenshot Carousel
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: project.screenshots.map((screenshot) => Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(screenshot, width: 180, height: 200, errorBuilder: (_, __, ___) =>
                    Container(width: 180, height: 200, color: Colors.grey, child: const Center(child: Text('Screenshot'))),
                  ),
                ),
              )).toList(),
            ),
          ),
          const SizedBox(height: 24),

          // Role + Category
          Row(
            children: [
              Chip(label: Text(project.role)),
              const SizedBox(width: 12),
              Chip(label: Text(project.category)),
            ],
          ),
          const SizedBox(height: 16),

          // Design Challenge
          const Text('Design Challenge', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(project.summary, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),

          // Performance Metrics
          const Text('Performance Metrics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: project.metrics.map((m) => Expanded(
              child: Column(
                children: [
                  Text(m.value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text(m.label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            )).toList(),
          ),
          const SizedBox(height: 24),

          // Tech Stack Tag-Cloud
          const Text('Tech Stack', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: project.techStack.map((tag) => InkWell(
              onTap: () => _showTechStackDetail(tag),
              child: Chip(
                label: Text(tag),
                backgroundColor: Colors.blue.shade100,
              ),
            )).toList(),
          ),
          const SizedBox(height: 24),

          // GitHub + Play Store Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => openExternal(project.githubUrl),
                  icon: const Icon(Icons.code),
                  label: const Text('GitHub Repository'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => openExternal(project.playStoreUrl),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Play Store'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showTechStackDetail(String tag) {
    // Placeholder for tech stack detail dialog
  }
}

// ========== PORTFOLIO APP ==========
class AndroidDevPortfolio extends StatelessWidget {
  const AndroidDevPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Android Developer Portfolio',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: Colors.blue,
          secondary: Colors.blue.shade300,
        ),
      ),
      home: const PortfolioHomePage(projects: sampleProjects),
    );
  }
}

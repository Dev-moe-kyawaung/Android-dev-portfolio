import 'package:flutter/material.dart';
import '../../models/project.dart';
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/responsive_layout.dart';
import '../../shared/widgets/section_title.dart';
import '../projects/project_detail_page.dart';

class PortfolioHomePage extends StatelessWidget {
  final List<Project> projects;

  const PortfolioHomePage({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: ResponsiveLayout(
        mobile: _buildProjectGrid(context),
        tablet: _buildProjectGrid(context),
        desktop: _buildProjectGrid(context),
      ),
    );
  }

  Widget _buildProjectGrid(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Moe Kyaw Aung', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
              const Text('Senior Android Developer', style: TextStyle(fontSize: 24, color: Colors.white70)),
              const SizedBox(height: 16),
              const Text('5 years shipping production Android apps', style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 24),
              Row(
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text('View Projects')),
                  const SizedBox(width: 16),
                  OutlinedButton(onPressed: () {}, child: const Text('Download Resume')),
                ],
              ),
            ],
          ),
        ),
        SectionTitle(title: 'Featured Projects'),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return ProjectCard(project: projects[index], onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ProjectDetailPage(project: projects[index])));
              });
            },
          ),
        ),
      ],
    );
  }
}

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
              Wrap(spacing: 8, children: project.techStack.take(3).map((tag) => Chip(label: Text(tag, style: const TextStyle(fontSize: 12)))).toList()),
            ],
          ),
        ),
      ),
    );
  }
}

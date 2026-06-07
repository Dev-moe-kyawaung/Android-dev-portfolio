import 'package:flutter/material.dart';
import '../../models/project.dart';
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/utils/url_utils.dart';

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
          Row(children: [Chip(label: Text(project.role)), const SizedBox(width: 12), Chip(label: Text(project.category))]),
          const SizedBox(height: 16),
          const Text('Design Challenge', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(project.summary, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          const Text('Performance Metrics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(children: project.metrics.map((m) => Expanded(child: Column(children: [Text(m.value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), Text(m.label, style: const TextStyle(fontSize: 12, color: Colors.grey))])).toList())),
          const SizedBox(height: 24),
          const Text('Tech Stack', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(spacing: 8, children: project.techStack.map((tag) => InkWell(onTap: () {}, child: Chip(label: Text(tag), backgroundColor: Colors.blue.shade100))).toList()),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: ElevatedButton.icon(onPressed: () => openExternal(project.githubUrl), icon: const Icon(Icons.code), label: const Text('GitHub Repository'))),
              const SizedBox(width: 12),
              Expanded(child: ElevatedButton.icon(onPressed: () => openExternal(project.playStoreUrl), icon: const Icon(Icons.play_arrow), label: const Text('Play Store'))),
            ],
          ),
        ],
      ),
    );
  }
}

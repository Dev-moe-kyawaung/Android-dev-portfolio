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

class ArticleMeta {
  final int id;
  final String title;
  final String description;
  final int duration; // menit
  final List<String> moods;
  final List<String> paragraphs;
  final String sourceUrl;
  final String thumbnail; // logo / image
  ArticleMeta({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.moods,
    required this.paragraphs,
    required this.sourceUrl,
    required this.thumbnail,
  });
}

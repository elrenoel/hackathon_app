import 'package:flutter/material.dart';
import 'package:hackathon_app/pages/read_task_page.dart';
import 'package:hackathon_app/data/article_dummy.dart';
import 'package:hackathon_app/models/article_meta.dart';
import 'package:hackathon_app/services/reading_progress_service.dart';
import 'dart:math';
import 'package:hackathon_app/services/auth_service.dart';

class DeepReadPage extends StatefulWidget {
  const DeepReadPage({super.key});

  @override
  State<DeepReadPage> createState() => _DeepReadPageState();
}

class _DeepReadPageState extends State<DeepReadPage> {
  Map<String, dynamic>? _user;
  bool _loadingUser = true;

  List<ArticleMeta> get articles => getDefaultArticles();

  final List<String> _focusOpeners = [
    'Fokusmu hari ini cukup seimbang.',
    'Hari ini ritme fokusmu berada di kondisi yang stabil.',
    'Kondisi fokusmu hari ini terjaga dengan baik.',
  ];

  final List<String> _focusDirections = [
    'Luangkan waktu membaca secara perlahan.',
    'Cukupkan diri dengan membaca tanpa terburu-buru.',
    'Ambil jeda dan nikmati setiap bacaan.',
  ];

  final List<String> _focusClosings = [
    'Tidak perlu banyak, yang penting tetap sadar.',
    'Fokus pada kualitas, bukan jumlah.',
    'Biarkan pikiran bekerja dengan ritmenya sendiri.',
  ];

  final List<String> motivationalQuotes = [
    'Pelan itu bukan lambat, tapi sadar.',
    'Satu artikel hari ini, satu langkah lebih fokus.',
    'Konsistensi kecil lebih kuat dari motivasi besar.',
    'Fokus bukan soal waktu lama, tapi niat penuh.',
    'Baca satu, pahami satu, itu sudah cukup.',
    'Otakmu tidak lelah, hanya butuh ritme.',
    'Sedikit demi sedikit tetap progres.',
  ];

  late String currentQuote;
  late String focusDescription;

  String get focusType => 'Balanced Focus';

  final int targetMinutes = 30;
  final int targetArticles = 3;
  final int targetQuestions = 10;

  int get progressMinutes => ReadingProgressService.minutesReadToday;
  int get progressArticles => ReadingProgressService.articlesReadToday;
  bool get isArticleTargetReached => progressArticles >= targetArticles;

  @override
  void initState() {
    super.initState();
    _fetchUser();
    focusDescription = _generateFocusDescription();
    _generateRandomQuote();
  }

  Future<void> _fetchUser() async {
    final user = await AuthService.getCurrentUser();
    if (!mounted) return;
    setState(() {
      _user = user;
      _loadingUser = false;
    });
  }

  String _generateFocusDescription() {
    final random = Random();
    return '${_focusOpeners[random.nextInt(_focusOpeners.length)]} '
        '${_focusDirections[random.nextInt(_focusDirections.length)]} '
        '${_focusClosings[random.nextInt(_focusClosings.length)]}';
  }

  void _generateRandomQuote() {
    final random = Random();
    currentQuote =
        motivationalQuotes[random.nextInt(motivationalQuotes.length)];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= HEADER =================
            Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1, 1),
                        blurRadius: 3,
                        color: Colors.black.withOpacity(0.15),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/icons/bro.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _loadingUser
                            ? 'Loading...'
                            : '${_user?['name'] ?? 'User'}, $focusType!',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 6,
                              color: Colors.black.withOpacity(0.15),
                            ),
                          ],
                        ),
                        child: Text(
                          focusDescription,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ================= READING ACTIVITY =================
            Text(
              'Reading Activity',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: 12),

            _ReadingActivityItem(
              icon: Icons.timer,
              title: 'Minutes',
              target: '$targetMinutes minutes',
              completed: '$progressMinutes minutes',
            ),
            const SizedBox(height: 10),

            _ReadingActivityItem(
              icon: Icons.book,
              title: 'Articles',
              target: '$targetArticles articles',
              completed: '$progressArticles articles',
            ),
            const SizedBox(height: 10),

            _ReadingActivityItem(
              icon: Icons.question_mark,
              title: 'Questions',
              target: '$targetQuestions questions',
              completed:
                  '${ReadingProgressService.questionsAnsweredToday} questions',
            ),

            const SizedBox(height: 16),

            // ================= MOTIVATION =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black.withOpacity(0.15),
                  ),
                ],
              ),
              child: Text(
                currentQuote,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),

            const SizedBox(height: 20),

            // ================= ARTICLE RECOMMENDATION =================
            Text(
              'Article Recommendation',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: 12),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];

                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6,
                            color: Colors.black.withOpacity(0.12),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              article.thumbnail,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Estimated reading time: ${article.duration} minutes',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.play_arrow,
                              color: isArticleTargetReached
                                  ? Colors.grey
                                  : Colors.deepPurple,
                            ),
                            onPressed: isArticleTargetReached
                                ? null
                                : () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            ReadTaskPage(articleMeta: article),
                                      ),
                                    );
                                    setState(() {
                                      focusDescription =
                                          _generateFocusDescription();
                                      _generateRandomQuote();
                                    });
                                  },
                          ),
                        ],
                      ),
                    ),
                    if (isArticleTargetReached)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          'Daily article target reached',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ================= ACTIVITY ITEM =================
class _ReadingActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String target;
  final String completed;

  const _ReadingActivityItem({
    required this.icon,
    required this.title,
    required this.target,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(0.12)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 28, color: Colors.deepPurple),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 4),
                Text(
                  'Target: $target',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'Completed: $completed',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: completed.startsWith('0')
                        ? Colors.black54
                        : Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

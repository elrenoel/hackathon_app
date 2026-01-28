import 'package:flutter/material.dart';
import 'package:hackathon_app/pages/read_task_page.dart';
import 'package:hackathon_app/data/article_dummy.dart';
import 'package:hackathon_app/models/article_meta.dart';
import 'package:hackathon_app/services/reading_progress_service.dart';
import 'dart:math';
// import 'package:hackathon_app/services/mood_service.dart';
// import 'package:hackathon_app/utils/show_mood_checkin.dart';
// import 'package:hackathon_app/widgets/home_page_widget/daily_check_in_emotion.dart';

class DeepReadPage extends StatefulWidget {
  // final String mood;
  const DeepReadPage({super.key});
  @override
  State<DeepReadPage> createState() => _DeepReadPageState();
}

class _DeepReadPageState extends State<DeepReadPage> {
  // String get mood {
  //   final savedMood = MoodService.todayMood;
  //   if (savedMood.isEmpty) return 'Balanced';
  //   return savedMood;
  // }

  List<ArticleMeta> get articles {
    return getDefaultArticles();
  }

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
    _generateRandomQuote();
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
        padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(1, 1),
                        blurRadius: 3,
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.15),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: Image.asset(
                      'assets/icons/bro.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "(Name), a $focusType!",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),

                      SizedBox(height: 5),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(1, 1),
                              blurRadius: 6,
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.15),
                            ),
                          ],
                        ),
                        child: Text(
                          'Penjelasan singkat mengenai tingkat fokus yang dimiliki berdasarkan type dan rekomendasi waktu membaca dan banyak bacaan minimum yang dikonsumsi tiap harinya',
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

            SizedBox(height: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's Target (${focusType})",
                  style: Theme.of(context).textTheme.labelSmall,
                ),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (_, index) {
                    return _TargetItem(
                      icon: [
                        Icons.timer,
                        Icons.book,
                        Icons.question_mark_sharp,
                      ][index],
                      // title: ["45 menit", "5 artikel", "15 soal"][index],
                      title: [
                        "$targetMinutes menit",
                        "$targetArticles artikel",
                        "$targetQuestions soal",
                      ][index],
                    );
                  },
                ),

                const SizedBox(height: 20),

                Text(
                  "Today's Progress",
                  style: Theme.of(context).textTheme.labelSmall,
                ),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (_, index) {
                    return _TargetItem(
                      icon: [
                        Icons.timer,
                        Icons.book,
                        Icons.question_mark_sharp,
                      ][index],
                      title: [
                        "${ReadingProgressService.minutesReadToday} menit",
                        "${ReadingProgressService.articlesReadToday} artikel",
                        "-",
                      ][index],
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(1, 1),
                    blurRadius: 6,
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.15),
                  ),
                ],
              ),
              child: Text(
                currentQuote,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 15),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Article Recommendation',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 10),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(1, 1),
                            blurRadius: 6,
                            color: Colors.black.withOpacity(0.15),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            article.description,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text('⏱ ${article.duration} min'),
                              const Spacer(),
                              IconButton(
                                icon: Icon(
                                  Icons.play_arrow,
                                  color: isArticleTargetReached
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          ReadTaskPage(articleMeta: article),
                                    ),
                                  );
                                  setState(() {
                                    _generateRandomQuote();
                                  });
                                },
                              ),
                            ],
                          ),
                          if (isArticleTargetReached)
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                'Daily article target reached',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TargetItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _TargetItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(1, 1),
            blurRadius: 6,
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.15),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          const SizedBox(height: 4),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

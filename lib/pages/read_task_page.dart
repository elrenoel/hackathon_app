import 'package:flutter/material.dart';
import 'package:hackathon_app/models/article.dart';
import 'package:hackathon_app/models/article_meta.dart';
import 'package:hackathon_app/services/article_service.dart';
import 'dart:async';
import 'package:hackathon_app/services/reading_progress_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadTaskPage extends StatefulWidget {
  final ArticleMeta articleMeta;

  const ReadTaskPage({super.key, required this.articleMeta});

  @override
  State<ReadTaskPage> createState() => _ReadTaskPageState();
}

class _ReadTaskPageState extends State<ReadTaskPage> {
  Timer? _timer;
  // bool _timerInitialized = false;
  int _remainingSeconds = 0;
  String get formattedTime {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  final ScrollController _controller = ScrollController();
  final ValueNotifier<double> scrollPercent = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.articleMeta.duration * 60;

    _timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
    _controller.addListener(() {
      final max = _controller.position.maxScrollExtent;
      final current = _controller.position.pixels;
      if (max > 0) {
        scrollPercent.value = (current / max * 100).clamp(0, 100);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final article = widget.article;
    return FutureBuilder<Article>(
      future: ArticleService.fetchArticleContent(widget.articleMeta),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final article = snapshot.data!;
        // if (!_timerInitialized) {
        //   widget.articleMeta.duration * 60;
        // }

        // _timerInitialized = true;
        return Scaffold(
          body: Stack(
            children: [
              // Header
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 12,
                      left: 12,
                      top: 45,
                      bottom: 15,
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Colors.black.withOpacity(0.15),
                                offset: const Offset(0, 2), // y = 2
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Image.asset('assets/icons/backbtn.png'),
                          ),
                        ),

                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Deep Read',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                formattedTime,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.open_in_new),
                          tooltip: 'Open original article',
                          onPressed: () async {
                            final url = widget.articleMeta.sourceUrl;

                            if (url.isEmpty) return;

                            await launchUrl(
                              Uri.parse(url),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                        ),
                        ValueListenableBuilder<double>(
                          valueListenable: scrollPercent,
                          builder: (_, value, __) {
                            return Text(
                              "${value.toInt()} %",
                              style: Theme.of(context).textTheme.labelMedium,
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      controller: _controller,
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
                      itemCount: article.paragraphs.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              article.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            article.paragraphs[index - 1],
                            textAlign: TextAlign.justify,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontSize: 16,
                                  height: 1.8,
                                  letterSpacing: 0.2,
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              Positioned(
                right: 20,
                bottom: 20,
                child: ValueListenableBuilder<double>(
                  valueListenable: scrollPercent,
                  builder: (_, value, __) {
                    if (value < 85) return const SizedBox.shrink();

                    return ElevatedButton(
                      onPressed: () {
                        ReadingProgressService.addReadingSession(
                          minutes: widget.articleMeta.duration,
                        );

                        Navigator.pop(context); // balik ke DeepRead
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: Text(
                        'Finish Reading',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

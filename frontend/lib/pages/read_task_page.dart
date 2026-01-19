import 'package:flutter/material.dart';
import 'package:hackathon_app/models/article.dart';
import 'package:hackathon_app/services/article_service.dart';

class ReadTaskPage extends StatefulWidget {
  const ReadTaskPage({super.key});

  @override
  State<ReadTaskPage> createState() => _ReadTaskPageState();
}

class _ReadTaskPageState extends State<ReadTaskPage> {
  final ScrollController _controller = ScrollController();
  final ValueNotifier<double> scrollPercent = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final max = _controller.position.maxScrollExtent;
      final current = _controller.position.pixels;
      if (max > 0) {
        scrollPercent.value = (current / max * 100).clamp(0, 100);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Article>(
      future: ArticleService.fetchArticle('Artificial_intelligence'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final article = snapshot.data!;

        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                // Header
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 12,
                        left: 12,
                        top: 28,
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
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelMedium,
                                ),
                                Text(
                                  '09:32',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
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
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            );
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              article.paragraphs[index - 1],
                              style: Theme.of(
                                context,
                              ).textTheme.displayMedium?.copyWith(height: 1.8),
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
                        onPressed: () {},
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
          ),
        );
      },
    );
  }
}

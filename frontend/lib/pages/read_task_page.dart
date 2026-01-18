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
            appBar: AppBar(
              backgroundColor: Color(0xFFF5F5F5),
              leading: const BackButton(),
              centerTitle: true,
              title: const Text('Deep Read'),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ValueListenableBuilder<double>(
                    valueListenable: scrollPercent,
                    builder: (_, value, __) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("Scroll", style: TextStyle(fontSize: 12)),
                          Text("${value.toInt()} %"),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            body: Stack(
              children: [
                ListView.builder(
                  controller: _controller,
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 100),
                  itemCount: article.paragraphs.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          article.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        article.paragraphs[index - 1],
                        style: const TextStyle(fontSize: 16, height: 1.6),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

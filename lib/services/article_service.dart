// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:hackathon_app/data/article_dummy.dart';
import 'package:hackathon_app/models/article.dart';
import 'package:hackathon_app/models/article_meta.dart';
// import 'package:hackathon_app/data/article_dummy.dart';
// import 'package:hackathon_app/helper/html_parse.dart';

class ArticleService {
  static List<ArticleMeta> getArticlesByMood(String mood) {
    // return getArticlesByMood(mood);
    return allArticles.where((a) => a.moods.contains(mood)).take(3).toList();
  }

  static Future<Article> fetchArticleContent(ArticleMeta meta) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return Article(
      title: meta.title,
      paragraphs: meta.paragraphs,
      // sourceUrl: meta.sourceUrl,
    );
  }
}

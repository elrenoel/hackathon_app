import 'dart:convert';
import 'package:hackathon_app/helper/html_parse.dart';
import 'package:hackathon_app/models/article.dart';
import 'package:http/http.dart' as http;

class ArticleService {
  static Future<Article> fetchArticle(String title) async {
    final url = Uri.parse(
      'https://en.wikipedia.org/w/api.php'
      '?action=parse'
      '&page=$title'
      '&prop=text'
      '&format=json'
      '&origin=*',
    );

    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception('Failed to load article');
    }

    final json = jsonDecode(res.body);

    final html = json['parse']['text']['*'];
    final paragraphs = htmlToParagraphs(html);

    return Article(title: json['parse']['title'], paragraphs: paragraphs);
  }
}

import 'package:html/parser.dart';

List<String> htmlToParagraphs(String html) {
  final document = parse(html);

  final paragraphs = document
      .querySelectorAll('p')
      .map((e) => e.text.trim())
      .where((text) => text.isNotEmpty && text.length > 40)
      .toList();

  return paragraphs;
}

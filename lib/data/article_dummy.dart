import '../models/article_meta.dart';

List<String> dummyParagraphs(String title) {
  return [
    '$title — paragraf 1. Ini adalah contoh bacaan untuk latihan deep read.',
    'Paragraf 2. Fokus membaca secara perlahan dan pahami isi.',
    'Paragraf 3. Tidak perlu panjang, ini dummy tapi strukturnya real.',
    'Paragraf 4. Nantinya bisa diganti API / markdown / Wikipedia.',
  ];
}

final List<ArticleMeta> allArticles = [
  // 🟢 HAPPY
  ArticleMeta(
    id: 1,
    title: 'Flow State for Deep Focus',
    description: 'Cara masuk ke kondisi fokus maksimal tanpa distraksi.',
    duration: 15,
    moods: ['Happy'],
    sourceUrl: 'https://medium.com/@username/focus-superpower',
    paragraphs: dummyParagraphs('Flow State for Deep Focus'),
  ),
  ArticleMeta(
    id: 2,
    title: 'Build Momentum While You’re Happy',
    description: 'Memanfaatkan mood positif untuk produktivitas.',
    duration: 20,
    moods: ['Happy'],
    sourceUrl: 'https://medium.com/@username/focus-superpower',
    paragraphs: dummyParagraphs('Flow State for Deep Focus'),
  ),
  ArticleMeta(
    id: 3,
    title: 'Deep Work Explained',
    description: 'Kenapa fokus panjang itu skill langka.',
    duration: 25,
    moods: ['Happy'],
    sourceUrl: 'https://medium.com/@username/focus-superpower',
    paragraphs: dummyParagraphs('Flow State for Deep Focus'),
  ),

  // 🟡 TIRED
  ArticleMeta(
    id: 4,
    title: 'Short Focus Reading',
    description: 'Bacaan ringan saat energi menurun.',
    duration: 10,
    moods: ['Tired'],
    sourceUrl: 'https://medium.com/@username/focus-superpower',
    paragraphs: dummyParagraphs('Flow State for Deep Focus'),
  ),
  ArticleMeta(
    id: 5,
    title: 'Recover Your Energy',
    description: 'Cara membaca tanpa bikin tambah capek.',
    duration: 12,
    moods: ['Tired'],
    sourceUrl: 'https://medium.com/@username/focus-superpower',
    paragraphs: dummyParagraphs('Flow State for Deep Focus'),
  ),
  ArticleMeta(
    id: 6,
    title: 'Micro Focus Technique',
    description: 'Fokus singkat tapi efektif.',
    duration: 8,
    moods: ['Tired'],
    sourceUrl: 'https://medium.com/@username/focus-superpower',
    paragraphs: dummyParagraphs('Flow State for Deep Focus'),
  ),

  // 🔵 STRESS
  ArticleMeta(
    id: 7,
    title: 'Calming Your Mind',
    description: 'Menurunkan stres lewat bacaan reflektif.',
    duration: 15,
    moods: ['Stress'],
    sourceUrl: 'https://medium.com/@username/focus-superpower',
    paragraphs: dummyParagraphs('Flow State for Deep Focus'),
  ),
  ArticleMeta(
    id: 8,
    title: 'Read to Reset',
    description: 'Reset pikiran sebelum lanjut kerja.',
    duration: 18,
    sourceUrl: 'https://medium.com/@username/focus-superpower',
    moods: ['Stress'],
    paragraphs: dummyParagraphs('Flow State for Deep Focus'),
  ),
  ArticleMeta(
    id: 9,
    title: 'Slow Reading Practice',
    description: 'Membaca pelan untuk menenangkan pikiran.',
    duration: 20,
    moods: ['Stress'],
    sourceUrl: 'https://medium.com/@username/focus-superpower',
    paragraphs: dummyParagraphs('Flow State for Deep Focus'),
  ),
  ArticleMeta(
    id: 10,
    title: 'Why Focus Is the New Superpower',
    description: 'Bagaimana fokus mengalahkan bakat di era distraksi.',
    duration: 12,
    moods: ['Balanced'],
    sourceUrl: 'https://medium.com/@username/focus-superpower',
    paragraphs: dummyParagraphs('Deep Work in a Shallow World'),
  ),
  ArticleMeta(
    id: 11,
    title: 'Deep Work in a Shallow World',
    description: 'Strategi bertahan dari notifikasi & dopamine trap.',
    duration: 15,
    moods: ['Balanced'],
    sourceUrl: 'https://medium.com/@username/deep-work-shallow-world',
    paragraphs: dummyParagraphs('Deep Work in a Shallow World'),
  ),
  ArticleMeta(
    id: 12,
    title: 'Reading Slowly Is a Skill',
    description: 'Kenapa membaca pelan justru bikin lebih paham.',
    duration: 10,
    moods: ['Balanced'],
    sourceUrl: 'https://medium.com/@username/slow-reading',
    paragraphs: dummyParagraphs('Deep Work in a Shallow World'),
  ),
  ArticleMeta(
    id: 13,
    title: 'Mental Fatigue Explained',
    description: 'Apa yang sebenarnya bikin otak capek.',
    duration: 8,
    moods: ['Balanced'],
    sourceUrl: 'https://medium.com/@username/mental-fatigue',
    paragraphs: dummyParagraphs('Deep Work in a Shallow World'),
  ),
  ArticleMeta(
    id: 14,
    title: 'Build a Daily Reading Habit',
    description: 'Cara bikin baca jadi kebiasaan tanpa maksa.',
    duration: 14,
    moods: ['Balanced'],
    sourceUrl: 'https://medium.com/@username/daily-reading-habit',
    paragraphs: dummyParagraphs('Deep Work in a Shallow World'),
  ),
];

List<ArticleMeta> getArticlesByMood(String mood) {
  return allArticles
      .where((article) => article.moods.contains(mood))
      // .take(3)
      .toList();
}

List<ArticleMeta> getDefaultArticles() {
  return allArticles.toList();
}

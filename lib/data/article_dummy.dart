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
    thumbnail: 'assets/icons/medium.jpg',
    sourceUrl:
        'https://medium.com/language-lab/how-to-learn-multiple-languages-at-the-same-time-005fb66f46a7',
    paragraphs: [
      'For a long time, I’ve been the strongest opponent to the idea of learning 2 languages at the same time. To be honest, this was probably due to the perfectionist in me, thinking that you need to dedicate as much time as possible to the target language of your choice.But learning 2 languages at the same time is not an impossible task. I grew up with 2 languages. I acquired both languages as a kid, so that’s kind of different. I’d also like to point out that Haitian Creole is a French Creole. This means that it shares lots of similarities with the French language.I also started learning Spanish while I was still an upper-intermediate student of English. I decided to learn Spanish…'
          'Language development Language development is a complex phenomenon, acting as a means of developing reasoning, thought and communication. The development of language is a mixture of learning and innate processes.Learning processesImitation plays some role in learning language, but cannot be the only means of developing language. Conditioning may also help the process, but adults do not pay attention to every detail of speech uttered by infants.Children also appear to learn a set of operating principles, which allows them to generalize certain constructions, e.g. the addition of ‘-ed’ to a verb to form the past tense, e.g. ‘walk, walked’. Children learn gradually not to over-generalize, e.g. ‘go, goed’, and to recognize irregular verbs.Innate processesAll children, regardless of culture, seem to go through the same sequence of language development, implying an innate knowledge. Language development also has critical periods when it is easier to learn languages, such as the early years of life.One of the foremost theorists in this area is Noam Chomsky, whose work has spawned a new science of neurolinguistics. He suggests that language development is built in (Chomsky 1972). The theory then becomes very dense, but a summary is shown in Table 4.3.Chomsky has been criticized on the grounds of reading adult meanings into childrens speech. He also believes that language should be studied separately from other aspects of development.',
    ],
  ),
  ArticleMeta(
    id: 2,
    title: 'Build Momentum While You’re Happy',
    description: 'Memanfaatkan mood positif untuk produktivitas.',
    duration: 20,
    moods: ['Happy'],
    thumbnail: 'assets/icons/medium.jpg',
    sourceUrl: 'https://medium.com/@username/focus-superpower',
    paragraphs: dummyParagraphs('Flow State for Deep Focus'),
  ),
  ArticleMeta(
    id: 3,
    title: 'Deep Work Explained',
    description: 'Kenapa fokus panjang itu skill langka.',
    duration: 25,
    moods: ['Happy'],
    thumbnail: 'assets/icons/medium.jpg',

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
    thumbnail: 'assets/icons/medium.jpg',

    sourceUrl: 'https://medium.com/@username/focus-superpower',
    paragraphs: dummyParagraphs('Flow State for Deep Focus'),
  ),
  ArticleMeta(
    id: 5,
    title: 'Recover Your Energy',
    description: 'Cara membaca tanpa bikin tambah capek.',
    duration: 12,
    moods: ['Tired'],
    thumbnail: 'assets/icons/medium.jpg',

    sourceUrl: 'https://medium.com/@username/focus-superpower',
    paragraphs: dummyParagraphs('Flow State for Deep Focus'),
  ),
  ArticleMeta(
    id: 6,
    title: 'Micro Focus Technique',
    description: 'Fokus singkat tapi efektif.',
    duration: 8,
    moods: ['Tired'],
    thumbnail: 'assets/icons/medium.jpg',

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
    thumbnail: 'assets/icons/medium.jpg',

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
    thumbnail: 'assets/icons/medium.jpg',

    paragraphs: dummyParagraphs('Flow State for Deep Focus'),
  ),
  ArticleMeta(
    id: 9,
    title: 'Slow Reading Practice',
    description: 'Membaca pelan untuk menenangkan pikiran.',
    duration: 20,
    thumbnail: 'assets/icons/medium.jpg',

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
    thumbnail: 'assets/icons/medium.jpg',

    sourceUrl: 'https://medium.com/@username/focus-superpower',
    paragraphs: dummyParagraphs('Deep Work in a Shallow World'),
  ),
  ArticleMeta(
    id: 11,
    title: 'Deep Work in a Shallow World',
    description: 'Strategi bertahan dari notifikasi & dopamine trap.',
    duration: 15,
    moods: ['Balanced'],
    thumbnail: 'assets/icons/medium.jpg',

    sourceUrl: 'https://medium.com/@username/deep-work-shallow-world',
    paragraphs: dummyParagraphs('Deep Work in a Shallow World'),
  ),
  ArticleMeta(
    id: 12,
    title: 'Reading Slowly Is a Skill',
    description: 'Kenapa membaca pelan justru bikin lebih paham.',
    duration: 10,
    moods: ['Balanced'],
    thumbnail: 'assets/icons/medium.jpg',

    sourceUrl: 'https://medium.com/@username/slow-reading',
    paragraphs: dummyParagraphs('Deep Work in a Shallow World'),
  ),
  ArticleMeta(
    id: 13,
    title: 'Mental Fatigue Explained',
    description: 'Apa yang sebenarnya bikin otak capek.',
    duration: 8,
    moods: ['Balanced'],
    thumbnail: 'assets/icons/medium.jpg',

    sourceUrl: 'https://medium.com/@username/mental-fatigue',
    paragraphs: dummyParagraphs('Deep Work in a Shallow World'),
  ),
  ArticleMeta(
    id: 14,
    title: 'Build a Daily Reading Habit',
    description: 'Cara bikin baca jadi kebiasaan tanpa maksa.',
    duration: 14,
    moods: ['Balanced'],
    thumbnail: 'assets/icons/medium.jpg',

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

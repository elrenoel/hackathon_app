import 'package:flutter/material.dart';
import 'package:hackathon_app/pages/read_task_page.dart';

class DeepReadPage extends StatefulWidget {
  const DeepReadPage({super.key});

  @override
  State<DeepReadPage> createState() => _DeepReadPageState();
}

class _DeepReadPageState extends State<DeepReadPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
      child: Column(
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
                  child: Image.asset('assets/icons/bro.jpg', fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "(Name), a (Type)!",
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
                "Today's Target",
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
                  childAspectRatio: 1.4,
                ),
                itemBuilder: (_, index) {
                  return _TargetItem(
                    icon: [
                      Icons.timer,
                      Icons.book,
                      Icons.question_mark_sharp,
                    ][index],
                    title: ["45 menit", "5 artikel", "15 soal"][index],
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
                  childAspectRatio: 1.4,
                ),
                itemBuilder: (_, index) {
                  return _TargetItem(
                    icon: [
                      Icons.timer,
                      Icons.book,
                      Icons.question_mark_sharp,
                    ][index],
                    title: ["25 menit", "3 artikel", "9 soal"][index],
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
              'komentar penyemangat untuk mencapai target',
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
              SizedBox(height: 10),
              Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xFFCACACA),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Title',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Text(
                                'Description duis aute irure dolor in reprehenderit in voluptate velit',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.add_circle_outline),
                                  ),
                                  Expanded(child: Text('Today • 23 min')),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ReadTaskPage(),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.play_arrow),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
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
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

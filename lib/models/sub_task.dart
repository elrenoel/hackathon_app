class SubTask {
  final String title;
  bool isDone;

  SubTask({required this.title, this.isDone = false});

  Map<String, dynamic> toJson() => {'title': title, 'isDone': isDone};
}

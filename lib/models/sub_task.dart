class SubTask {
  final int? id;
  final String title;
  final bool isDone;
  final int? todoId;

  SubTask({this.id, required this.title, this.isDone = false, this.todoId});

  Map<String, dynamic> toJson() => {
    "title": title, // backend hanya butuh ini saat create
  };

  factory SubTask.fromJson(Map<String, dynamic> json) {
    return SubTask(
      id: json['id'],
      title: json['title'],
      isDone: json['is_done'] ?? false,
      todoId: json['todo_id'],
    );
  }
}

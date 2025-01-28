class Todo {
  final int id;
  final String title;
  final int isCompleted;

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = 0
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      isCompleted: json['completed'] ?? 0,
    );
  }
}
abstract class TodoEvent {}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;
  final String? imagePath;
  AddTodo({
    required this.title,
    this.imagePath
  });
}

class DeleteTodo extends TodoEvent {
  final int id;
  DeleteTodo({
    required this.id
  });
}
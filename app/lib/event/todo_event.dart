abstract class TodoEvent {}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;
  AddTodo({
    required this.title
  });
}

class DeleteTodo extends TodoEvent {
  final int id;
  DeleteTodo({
    required this.id
  });
}
import 'package:app/model/todo_model.dart';

abstract class TodoState {}

//Todo Fetching
class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;

  TodoLoaded({required this.todos});
}

// Todo Creating

class TodoCreate extends TodoState {
  final String title;

  TodoCreate({
    required this.title
  });
}

//Todo Deleting

class TodoDelete extends TodoState {}


// Error Fetching
class TodoError extends TodoState {
  final String message;

  TodoError({required this.message});
}
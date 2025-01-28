import 'package:app/event/todo_event.dart';
import 'package:app/model/todo_model.dart';
import 'package:app/services/todo_services.dart';
import 'package:app/state/todo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TodoBloc extends Bloc<TodoEvent,TodoState> {
  final TodoServices todoServices;

  TodoBloc({required this.todoServices}) : super(TodoInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onCreateTodo);
    on<DeleteTodo>(_onDeleteTodo);
  }

  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      final todos = await todoServices.fetchTodos();
      emit(TodoLoaded(todos: todos));
    } catch (error) {
      emit(TodoError(message: error.toString()));
    }
  }

  Future<void> _onCreateTodo(AddTodo event, Emitter<TodoState> emit) async {
    try {
      if (state is TodoLoaded){
        final newTodo = await todoServices.createTodo(event.title);
        final updatedTodos = List<Todo>.from((state as TodoLoaded).todos)..add(newTodo);
        emit(TodoLoaded(todos: updatedTodos));
      }
    } catch (error) {
      emit(TodoError(message: error.toString()));
    }
  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    try{
      if (state is TodoLoaded){
        await todoServices.deleteTodo(event.id);
        final updatedTodos = (state as TodoLoaded)
          .todos
          .where((todo) => todo.id != event.id)
          .toList();
        emit(TodoLoaded(todos: updatedTodos));
      }
    }catch (error) {
      emit(TodoError(message: error.toString()));
    }
  }
}
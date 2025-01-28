import 'package:app/bloc/todo_bloc.dart';
import 'package:app/event/todo_event.dart';
import 'package:app/state/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Todo App'
        ),
      ),
      body: TodoView(),
    );
  }
}

class TodoView extends StatelessWidget {

  TodoView({super.key});

  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              return TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Enter todo title',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      final title = _titleController.text.trim();
                      if (title.isNotEmpty){
                        context.read<TodoBloc>().add(AddTodo(title: title));
                        _titleController.clear();
                      }
                    },
                  ),
                ),
              );
            },
          )
        ),
        Expanded(
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state is TodoLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TodoLoaded) {
                final todos = state.todos;
                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return ListTile(
                      title: Text(todo.title),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<TodoBloc>().add(DeleteTodo(id: todo.id));
                        },
                      ),
                    );
                  },
                );
              } else if (state is TodoError) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text('No todos available.'));
              }
            },
          ),
        ),
      ],
    );
  }
}


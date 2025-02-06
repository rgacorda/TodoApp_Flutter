import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_bloc.dart';
import '../event/todo_event.dart';
import '../state/todo_state.dart';

class TodoView extends StatelessWidget {
  TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                      leading: (todo.imagePath != null && File(todo.imagePath!).existsSync())
                          ? Image.file(
                            File(todo.imagePath!),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                          : const SizedBox(width: 50),
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
import 'dart:convert';
import 'package:app/model/todo_model.dart';
import 'package:http/http.dart' as http;

class TodoServices {
  static const String baseUrl = 'http://10.0.2.2:8000';

  Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse('$baseUrl/todos'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Todo.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load todos. Status code: ${response.statusCode}');
    }
  }

  Future<Todo> createTodo(String title) async {
    final response = await http.post(
      Uri.parse('$baseUrl/todos'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': title}),
    );
    if (response.statusCode == 201) {
      return Todo.fromJson(json.decode(response.body));
    }
    throw Exception('Failed to create todo');
  }

  Future<void> deleteTodo(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/todos/$id')
    );
    if (response.statusCode != 204){
      throw Exception('Failed to delete todo');
    }
  }
}
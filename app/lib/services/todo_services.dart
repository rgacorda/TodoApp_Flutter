import 'package:app/model/todo_model.dart';
import 'package:dio/dio.dart';

class TodoServices {
  static const String baseUrl = 'http://10.0.2.2:8000';

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl, headers: {'Content-Type': 'application/json'}));


  Future<List<Todo>> fetchTodos() async {
    try {
      final response = await _dio.get('/todos');

      if (response.data is List) {
        return await Future.wait(
          (response.data as List).map((e) async => await Todo.fromJson(e)),
        );
      } else {
        throw Exception("Invalid response format: Expected a list.");
      }
    } on DioException catch (e) {
      throw Exception('Failed to load todos: ${e.response?.statusCode} - ${e.message}');
    }
  }

  Future<Todo> createTodo(String title, String? imagePath) async {
    try {
      FormData formData = FormData.fromMap({
        'title': title,
        if (imagePath != null) 'image': await MultipartFile.fromFile(imagePath),
      });

      final response = await _dio.post('/todos', data: formData);

      if (response.statusCode == 201) {
        print(imagePath);
        return Todo.fromJson(response.data);
      } else {
        throw Exception('Failed to create todo: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to create todo: ${e.response?.statusCode} - ${e.message}');
    }
  }


  Future<void> deleteTodo(int id) async {
    try {
      await _dio.delete('/todos/$id');
    } on DioException catch (e) {
      throw Exception('Failed to delete todo: ${e.response?.statusCode} - ${e.message}');
    }
  }
}
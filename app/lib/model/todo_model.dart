import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class Todo {
  final int id;
  final String title;
  final int isCompleted;
  String? imagePath;

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = 0,
    this.imagePath,
  });

  static Future<Todo> fromJson(Map<String, dynamic> json) async {
    String? localImagePath;
    if (json['image'] != null) {
      String imageUrl = json['image'];
      if (!imageUrl.startsWith('http')) {
        imageUrl = 'http://10.0.2.2:8000/storage/$imageUrl';
      }

      localImagePath = await _downloadImage(imageUrl);
    }

    return Todo(
      id: json['id'],
      title: json['title'],
      isCompleted: json['completed'] ?? 0,
      imagePath: localImagePath,
    );
  }


  static Future<String> _downloadImage(String imageUrl) async {
    try {
      final Directory dir = await getApplicationDocumentsDirectory();
      final String filePath = '${dir.path}/${imageUrl.split('/').last}';

      if (File(filePath).existsSync()) {
        return filePath;
      }

      final Dio dio = Dio();
      await dio.download(imageUrl, filePath);
      return filePath;
    } catch (e) {
      print("Error downloading image: $e");
      return imageUrl;
    }
  }
}

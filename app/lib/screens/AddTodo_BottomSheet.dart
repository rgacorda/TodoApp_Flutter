import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/todo_bloc.dart';
import '../event/todo_event.dart';

void showAddTodoSheet(BuildContext context) async {
  final Map<String, dynamic>? newTodo = await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => AddTodoBottomSheet(),
  );

  if (newTodo != null) {
    String title = newTodo['title'];
    String? imagePath = newTodo['imagePath'];
    context.read<TodoBloc>().add(AddTodo(title: title, imagePath: imagePath));
  }
}

class AddTodoBottomSheet extends StatefulWidget {
  const AddTodoBottomSheet({super.key});

  @override
  State<AddTodoBottomSheet> createState() => _AddTodoBottomSheetState();
}

class _AddTodoBottomSheetState extends State<AddTodoBottomSheet> {
  TextEditingController todoController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Add Todo",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          TextField(
            controller: todoController,
            decoration: InputDecoration(
              labelText: "Assignment Title",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 15),
          GestureDetector(
            onTap: _pickImage,
            child: _selectedImage != null
                ? Image.file(
              _selectedImage!,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            )
                : Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.camera_alt,
                size: 50,
                color: Colors.grey[700],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String newTodo = todoController.text;
              if (newTodo.isNotEmpty) {
                Navigator.pop(context, {
                  'title': newTodo,
                  'imagePath': _selectedImage?.path
                });
              }
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }
}




import 'package:app/bloc/todo_bloc.dart';
import 'package:app/event/todo_event.dart';
import 'package:app/screens/home.dart';
import 'package:app/services/todo_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(){
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoBloc(todoServices: TodoServices())..add(LoadTodos()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen()
        },
      )
    )
  );
}

// void main(){
//   runApp(
//     MaterialApp(
//       home: HomeScreen(),
//     )
//   );
// }
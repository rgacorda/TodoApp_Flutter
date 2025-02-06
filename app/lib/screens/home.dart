import 'package:app/bloc/todo_bloc.dart';
import 'package:app/event/todo_event.dart';
import 'package:app/screens/ViewTodo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'AddTodo_BottomSheet.dart';


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
      body: Container(
          child: TodoView()
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showAddTodoSheet(context),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.fromLTRB(12, 16, 12, 32),
        child: GNav(
            haptic: true, // haptic feedback
            tabBorderRadius: 50,
            tabActiveBorder: Border.all(color: Colors.black, width: 1), // tab button bordertab button border
            curve: Curves.easeOutExpo, // tab animation curves
            duration: Duration(milliseconds: 300), // tab animation duration
            gap: 8, // the tab button gap between icon and text
            color: Colors.grey[800], // unselected icon color
            activeColor: Colors.black, // selected icon and text color
            iconSize: 32, // tab button icon size
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10), // navigation bar padding
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.search,
                text: 'Search',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              )
            ]
        ),
      ),
    );
  }
}




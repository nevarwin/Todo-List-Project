import 'package:flutter/material.dart';

import 'package:todo_app_project/screens/edit_todo_screen.dart';
import '../models/todo.dart';
import '../widgets/todo_desc.dart';

class TodoDescScreen extends StatelessWidget {
  const TodoDescScreen({Key? key}) : super(key: key);

  static const routeName = '/TodoDescScreen';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>;

    final todoList = args['list'] as List<Todo>;
    final individual = args['indi'] as Todo;

    return Scaffold(
      appBar: AppBar(
        title: Text(individual.title),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(
              EditTodoScreen.routeName,
              arguments: {
                'indi': individual,
                'list': todoList,
              },
            ),
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: Center(
        child: TodoDesc(
          title: individual.title,
          date: individual.date,
          importance: individual.importance,
          label: individual.label,
        ),
      ),
    );
  }
}

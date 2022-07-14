import 'package:flutter/material.dart';

import '../models/todo.dart';

class TodoList extends StatelessWidget {
  TodoList({Key? key}) : super(key: key);
  final List<Todo> allTodos = [
    Todo(
      id: DateTime.now().toString(),
      title: 'Task1',
      importance: Importance.low,
      label: Label.todo,
    ),
    Todo(
      id: DateTime.now().toString(),
      title: 'Task2',
      importance: Importance.medium,
      label: Label.doing,
    ),
    Todo(
      id: DateTime.now().toString(),
      title: 'Task2',
      importance: Importance.high,
      label: Label.done,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return allTodos.isEmpty
        ? const Text('No todos')
        : ListView.builder(itemBuilder: (context, index) {
            return ListTile(
              subtitle: Column(
                children: [
                  Text(allTodos[index].title),
                  Chip(
                    label: Text(
                      allTodos[index].importance.toString(),
                    ),
                  ),
                ],
              ),
            );
          });
  }
}

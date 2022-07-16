import 'package:flutter/material.dart';

import '../models/todo.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    Key? key,
    required this.allTodos,
  }) : super(key: key);

  final List<Todo> allTodos;

  @override
  Widget build(BuildContext context) {
    return allTodos.isEmpty
        ? const Center(
            child: Text('No todos'),
          )
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
                  Chip(
                    label: Text(
                      allTodos[index].label.toString(),
                    ),
                  ),
                ],
              ),
            );
          });
  }
}
